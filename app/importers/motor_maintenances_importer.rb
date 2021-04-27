class MotorMaintenancesImporter < BaseImporter
  private

  def model_class
    MotorMaintenance
  end

  def on_duplicate_key_update
    [:exchanged_parts, :quantity]
  end
end
