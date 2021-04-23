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

# == Schema Information
#
# Table name: weather_conditions
#
#  stadium_tel_code  :integer          not null, primary key
#  date              :date             not null, primary key
#  race_number       :integer          not null, primary key
#  in_performance    :boolean          not null, primary key
#  weather           :integer          not null
#  wind_velocity     :float(24)        not null
#  wind_angle        :float(24)
#  wavelength        :float(24)
#  air_temperature   :float(24)        not null
#  water_temperature :float(24)        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
