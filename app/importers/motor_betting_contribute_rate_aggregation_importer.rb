class MotorBettingContributeRateAggregationImporter < BaseImporter
  private

  def model_class
    MotorBettingContributeRateAggregation
  end

  def on_duplicate_key_update
    [:quinella_rate, :trio_rate]
  end
end
