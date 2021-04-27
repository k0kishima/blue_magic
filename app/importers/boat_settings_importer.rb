class BoatSettingsImporter < BaseImporter
  private

  def model_class
    BoatSetting
  end

  def on_duplicate_key_update
    [:boat_number, :motor_number, :tilt, :propeller_renewed]
  end
end
