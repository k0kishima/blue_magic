class FetchBettingResultJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound, DataNotFound, DataNotPrepared

  def perform(date:, stadium_tel_code:, race_number:)
    race = Race.includes(:payoffs, :bettings).find_by!(stadium_tel_code: stadium_tel_code, date: date,
                                                       race_number: race_number)

    raise DataNotFound if race.bettings.blank?
    raise DataNotPrepared if race.payoffs.blank?

    ActiveRecord::Base.transaction do
      race.bettings.each do |betting|
        betting.adjustment_amount = 0
        betting.refunded_amount = 0

        race.payoffs.each do |payoff|
          next if payoff.betting_number != betting.betting_number

          if betting.dry_run
            decreased_ratio = SimulateOddsRatioDecreaseService.call(
              before_purchase_total_sales_per_one_race: EstimateRaceSalesService.call(betting_deadline_at: betting.voted_at),
              odds_ratio: betting.ratio_when_forecasting,
              purchase_amount: betting.betting_amount
            )
            betting.adjustment_amount = decreased_ratio * Ticket::YEN_PER_ONE_POINT
          end

          betting.refunded_amount = payoff.amount * (betting.betting_amount / Ticket::YEN_PER_ONE_POINT)
        end

        # hack: activerecord-import でのupsertが動かないので暫定的に個別に更新
        # Betting.import!(to_be_updated_bettings, all_or_none: true, on_duplicate_key_update: %w(refunded_amount adjustment_amount))
        # => NoMethodError: undefined method `to_sym' for ["forecasters_forecasting_pattern_id", "stadium_tel_code", "date", "race_number"]:CompositePrimaryKeys::CompositeKeys
        betting.save!
      end
    end
  end
end
