class BetJob < ApplicationJob
  class AnyForecastingPatternsDoNotMatched < StandardError; end

  discard_on ActiveRecord::RecordNotFound, Forecaster::AlreadyForecasted, AnyForecastingPatternsDoNotMatched,
             OverBudget, ActiveModel::ValidationError

  discard_on(DataNotFound, DataNotPrepared) do |job, error|
    Rails.application.config.betting_logger.info("#{job.arguments}: #{error.message}")
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
    betting_strategy = betting_strategy_class.new(recommend_odds: recommend_odds)
    betting_strategy.bet!
  end
end
