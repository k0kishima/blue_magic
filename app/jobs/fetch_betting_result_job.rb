class FetchBettingResultJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound, DataNotFound, DataNotPrepared

  def perform(date:, stadium_tel_code:, race_number:)
    race = Race.includes(:payoffs, :bettings).find_by!(stadium_tel_code: stadium_tel_code, date: date,
                                                       race_number: race_number)

    raise DataNotFound if race.bettings.blank?
    raise DataNotPrepared if race.payoffs.blank?

    to_be_updated_bettings = race.bettings.map do |betting|
      betting.adjustment_amount = 0
      betting.refunded_amount = (race.repayment_numbers & betting.betting_numbers).present? ? betting.betting_amount : 0

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

      betting
    end

    Betting.import!(to_be_updated_bettings, all_or_none: true, on_duplicate_key_update: %w(refunded_amount adjustment_amount))
  end
end
