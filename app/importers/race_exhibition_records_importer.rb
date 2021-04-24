class RaceExhibitionRecordsImporter < BaseImporter
  private

  def model_class
    RaceExhibitionRecord
  end

  def on_duplicate_key_update
    [:course_number, :start_time, :exhibition_time, :exhibition_time_order]
  end
end
