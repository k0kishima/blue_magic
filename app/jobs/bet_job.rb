class BetJob < ApplicationJob
  class AnyForecastingPatternsDoNotMatched < StandardError; end

  discard_on Forecaster::AlreadyForecasted, AnyForecastingPatternsDoNotMatched, OverBudget do |job, error|
    Rails.application.config.betting_logger.info("#{job.arguments}: #{error.message}")
  end

  discard_on ActiveRecord::RecordNotFound, KeyError, ArgumentError do |job, error|
    Rails.application.config.betting_logger.fatal("#{job.arguments}: #{error.message}".red)
  end

  def perform(forecaster_id:, stadium_tel_code:, race_opened_on:, race_number:)
    race =
      Race
      .includes(
        :weather_conditions,
        :odds,
        {
          race_entries: [
            :start_exhibition_record,
            :disqualified_race_entry,
            :racer_winning_rate_aggregation,
            { boat_setting: [:motor_betting_contribute_rate_aggregation, :boat_betting_contribute_rate_aggregation] },
          ]
        }
      ).find_by!(stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number)

    race.stadium.aggregation_offset_date = race.date
    race.stadium.context = race.weather_condition_in_exhibition.slice(:wind_angle, :wind_velocity)

    RankingSetting::RACE_ENTRY.each do |need_to_rank_attribute_name, evaluation_policy|
      RankedAttributeDecorator.bulk_decorate!(
        objects: race.race_entries,
        need_to_rank_attribute_name: need_to_rank_attribute_name,
        evaluation_policy: evaluation_policy
      )
    end

    forecaster = Forecaster.find(forecaster_id)
    recommend_odds = forecaster.forecast!(race)
    raise AnyForecastingPatternsDoNotMatched.new if recommend_odds.blank?

    betting_strategy_class = "BettingStrategy::#{forecaster.betting_strategy.camelize}".constantize

    # 二重投票防止のため、すでに bettings が登録されているものはここで省く
    recommend_odds_which_do_not_have_any_bettings = \
      recommend_odds
        .left_joins(:betting)
        .merge(Betting.where(forecasters_forecasting_pattern_id: nil))

    if recommend_odds_which_do_not_have_any_bettings.present?
      betting_strategy = betting_strategy_class.new(recommend_odds: recommend_odds_which_do_not_have_any_bettings)
      betting_strategy.bet!
    end
  end
end
