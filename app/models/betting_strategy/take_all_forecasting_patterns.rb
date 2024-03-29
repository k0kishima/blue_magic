module BettingStrategy
  class TakeAllForecastingPatterns < Base
    def bet!
      validate!

      bettings = recommend_odds.map do |o|
        o.build_betting(
          betting_number: o.betting_number,
          betting_amount: o.should_purchase_quantity * Ticket::YEN_PER_ONE_POINT,
          betting_method: :trifecta,
          dry_run: !Setting.voting_enable,
          voted_at: Time.zone.now,
        )
      end

      Betting.import!(bettings, all_or_none: true, raise_error: true, validate_uniqueness: true)

      vote!(bettings)
    end
  end
end
