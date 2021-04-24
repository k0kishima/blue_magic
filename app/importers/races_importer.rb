class RacesImporter < BaseImporter
  private

  def model_class
    Race
  end

  def on_duplicate_key_update
    [:course_fixed, :use_stabilizer, :betting_deadline_at, :title, :number_of_laps]
  end
end
