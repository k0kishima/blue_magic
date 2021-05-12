class SimulateOddsRatioDecreaseService
  include ServiceBase

  def call
    refund_amount / (current_total_sales_of_odds + self.purchase_amount)
  end

  private

  attr_accessor :before_purchase_total_sales_per_one_race, :odds_ratio, :purchase_amount

  def current_total_sales_per_one_race
    self.before_purchase_total_sales_per_one_race + self.purchase_amount
  end

  def current_total_sales_of_odds
    return refund_amount / self.odds_ratio
  end

  def refund_amount
    current_total_sales_per_one_race * Payoff::REFUND_RATE
  end
end
