class FundAllocationMethod
  module ID
    CANCEL_IF_OVER_BUDGET = 1
    BET_WITHIN_BUDGET_BY_ASC = 2
    BET_WITHIN_BUDGET_BY_DESC = 3
    ALL_BET = 4
  end

  def self.all
    ID.constants.map { |constant_name| ID.const_get(constant_name) }.sort
  end
end
