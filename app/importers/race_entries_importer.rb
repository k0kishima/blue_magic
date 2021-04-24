class RaceEntriesImporter < BaseImporter
  private

  def model_class
    RaceEntry
  end

  def on_duplicate_key_update
    [:racer_registration_number]
  end
end
