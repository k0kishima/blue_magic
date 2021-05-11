class StartExhibitionRecordsImporter < BaseImporter
  private

  def model_class
    StartExhibitionRecord
  end

  def on_duplicate_key_update
    [:course_number, :start_time]
  end
end
