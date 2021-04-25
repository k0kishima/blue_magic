class DisqualifiedRaceEntriesImporter < BaseImporter
  private

  def model_class
    DisqualifiedRaceEntry
  end

  def on_duplicate_key_update
    [:disqualification]
  end
end
