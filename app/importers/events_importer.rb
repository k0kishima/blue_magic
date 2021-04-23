class EventsImporter < BaseImporter
  private

  def model_class
    Event
  end

  def on_duplicate_key_update
    [:stadium_tel_code, :title, :starts_on, :grade, :kind]
  end
end
