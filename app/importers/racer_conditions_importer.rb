class RacerConditionsImporter < BaseImporter
  private

  def model_class
    RacerCondition
  end

  def on_duplicate_key_update
    [:weight, :adjust]
  end
end

