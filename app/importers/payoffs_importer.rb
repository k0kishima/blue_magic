class PayoffsImporter < BaseImporter
  private

  def model_class
    Payoff
  end

  def on_duplicate_key_update
    [:amount]
  end
end
