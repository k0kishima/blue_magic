class RacersImporter < BaseImporter
  private

  def model_class
    Racer
  end

  def on_duplicate_key_update
    [:last_name, :first_name, :term, :birth_date, :branch_id, :birth_prefecture_id, :height,]
  end
end

