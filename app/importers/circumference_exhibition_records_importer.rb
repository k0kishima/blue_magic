class CircumferenceExhibitionRecordsImporter < BaseImporter
  private

  def model_class
    CircumferenceExhibitionRecord
  end

  def on_duplicate_key_update
    [:exhibition_time, :exhibition_time_order]
  end
end
