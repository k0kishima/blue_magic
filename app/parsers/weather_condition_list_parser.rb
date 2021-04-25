class WeatherConditionListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :in_performance,
    :weather,
    :wavelength,
    :wind_angle,
    :wind_velocity,
    :air_temperature,
    :water_temperature,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        in_performance: ActiveRecord::Type::Boolean.new.cast(row[3]),
        weather: WeatherFactory.create!(row[4]),
        wavelength: row[5].to_f,
        wind_angle: row[6].to_f,
        wind_velocity: row[7].to_f,
        air_temperature: row[8].to_f,
        water_temperature: row[9].to_f,
      }
    end
  end
end
