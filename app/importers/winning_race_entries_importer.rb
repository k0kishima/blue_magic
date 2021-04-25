class WinningRaceEntriesImporter < BaseImporter
  private

  def model_class
    WinningRaceEntry
  end

  def on_duplicate_key_update
    [:winning_trick]
  end
end
