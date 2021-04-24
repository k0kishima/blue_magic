class RacerWinningRateAggregationImporter < BaseImporter
  private

  def model_class
    RacerWinningRateAggregation
  end

  def on_duplicate_key_update
    [:rate_in_all_stadium, :rate_in_event_going_stadium]
  end
end

