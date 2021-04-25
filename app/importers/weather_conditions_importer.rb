class WeatherConditionsImporter < BaseImporter
  private

  def model_class
    WeatherCondition
  end

  def on_duplicate_key_update
    [:weather, :wind_velocity, :wind_angle, :wavelength, :air_temperature, :water_temperature]
  end
end
