class BetJob < ApplicationJob
  class AnyForecastingPatternsDoNotMatched < StandardError; end

  discard_on ActiveRecord::RecordNotFound, Forecaster::AlreadyForecasted, AnyForecastingPatternsDoNotMatched

  def perform(forecaster_id:, stadium_tel_code:, race_opened_on:, race_number:)
    race = Race.find_by!(stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number)
    forecaster = Forecaster.find(forecaster_id)
    recommend_odds = forecaster.forecast!(race)
    raise AnyForecastingPatternsDoNotMatched.new if recommend_odds.blank?

    betting_strategy_class = "BettingStrategy::#{forecaster.betting_strategy.camelize}".constantize
    betting_strategy = betting_strategy_class.new(recommend_odds: recommend_odds)
    betting_strategy.bet!
  end
end
