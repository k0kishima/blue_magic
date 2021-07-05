class BetJob < ApplicationJob
  class AnyForecastingPatternsDoNotMatched < StandardError; end

  discard_on Forecaster::AlreadyForecasted, AnyForecastingPatternsDoNotMatched, OverBudget, RaceAnalysisCache::RaceCannotBeAnalyzed do |job, error|
    Rails.application.config.betting_logger.info("#{job.arguments}: #{error.message}")
  end

  discard_on ActiveRecord::RecordNotFound, KeyError, ArgumentError do |job, error|
    Rails.application.config.betting_logger.fatal("#{job.arguments}: #{error.message}".red)
  end

  def perform(forecaster_id:, stadium_tel_code:, race_opened_on:, race_number:)
    race = Race.find_by!(stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number)

    if race.race_analysis_cache.blank?
      RaceAnalysisCacheFactory.create!(date: race_opened_on, stadium_tel_code: stadium_tel_code, race_number: race_number)
      race.reload
    end

    if race.race_analysis_cache.error_message.present?
      raise RaceAnalysisCache::RaceCannotBeAnalyzed, race.race_analysis_cache.error_message
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
