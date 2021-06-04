module BettingStrategy
  class TakeTheFirstForecastingPattern < Base
    def bet!
      validate!

      # TODO: implement
      # vote! if Setting.voting_enable

      forecasters_forecasting_pattern_id = recommend_odds.map(&:forecasters_forecasting_pattern_id).first
      bettings = recommend_odds.select { |o|
                   o.forecasters_forecasting_pattern_id == forecasters_forecasting_pattern_id
                 }.map do |o|
        o.build_betting(
          betting_number: o.betting_number,
          betting_amount: o.should_purchase_quantity * Ticket::YEN_PER_ONE_POINT,
          betting_method: :trifecta,
          dry_run: !Setting.voting_enable,
          voted_at: Time.zone.now,
        )
      end

      Betting.import!(bettings, all_or_none: true, raise_error: true, validate_uniqueness: true)
    end
  end
end
