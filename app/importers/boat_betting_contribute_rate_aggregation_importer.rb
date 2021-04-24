class BoatBettingContributeRateAggregationImporter < BaseImporter
  private

  def model_class
    BoatBettingContributeRateAggregation
  end

  def on_duplicate_key_update
    [:quinella_rate, :trio_rate]
  end
end
