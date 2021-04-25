class RaceRecordsImporter < BaseImporter
  private

  def model_class
    RaceRecord
  end

  def on_duplicate_key_update
    [:course_number, :start_time, :start_order, :race_time, :arrival]
  end
end

