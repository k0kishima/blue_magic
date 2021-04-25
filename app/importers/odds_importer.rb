class OddsImporter < BaseImporter
  private

  def model_class
    Odds
  end

  def on_duplicate_key_update
    [:ratio]
  end
end
