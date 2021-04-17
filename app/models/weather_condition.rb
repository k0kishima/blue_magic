class WeatherCondition < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :in_performance]

  enum weather: { fine: 1, cloudy: 2, rainy: 3, snowy: 4, typhoon: 5, fog: 6, }

  belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true

  validates :in_performance, inclusion: { in: [true, false] }
  validates :weather, presence: true
  validates :wind_velocity, presence: true
  validates :air_temperature, presence: true
  validates :water_temperature, presence: true
end
