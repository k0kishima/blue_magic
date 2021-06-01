class OverBudget < StandardError; end

class FundAllocationService
  include ServiceBase

  def call
    unless fund_allocation_method.in?(FundAllocationMethod.all)
      raise ArgumentError,
            'Unknown fund allocation method specified.'
    end

    betting_number_and_should_purchase_quantities = []

    sorted_odds = odds.sort_by(&:ratio)
    sorted_odds = odds.reverse if fund_allocation_method == FundAllocationMethod::ID::BET_WITHIN_BUDGET_BY_DESC

    sorted_odds.each do |odds|
      should_purchase_quantity = target_amount / (odds.ratio * Ticket::YEN_PER_ONE_POINT)
      self.budget_amount -= should_purchase_quantity * Ticket::YEN_PER_ONE_POINT

      if self.budget_amount.negative?
        raise OverBudget if fund_allocation_method == FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET

        should_purchase_quantity = 0 unless fund_allocation_method == FundAllocationMethod::ID::ALL_BET
      end

      unless should_purchase_quantity.zero?
        betting_number_and_should_purchase_quantities << [odds.betting_number, should_purchase_quantity]
      end
    end

    betting_number_and_should_purchase_quantities.to_h
  end

  private

  attr_accessor :budget_amount, :target_amount, :odds, :fund_allocation_method
end
