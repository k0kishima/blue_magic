FactoryBot.define do
  factory :weather_condition do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    weather { :fine }
    air_temperature { 20 }
    water_temperature { 20 }
    in_performance { false }
    wind_angle { nil }
    wind_velocity { 0 }
  end
end

# == Schema Information
#
# Table name: weather_conditions
#
#  air_temperature   :float(24)        not null
#  date              :date             not null, primary key
#  in_performance    :boolean          not null, primary key
#  race_number       :integer          not null, primary key
#  stadium_tel_code  :integer          not null, primary key
#  water_temperature :float(24)        not null
#  wavelength        :float(24)
#  weather           :integer          not null
#  wind_angle        :float(24)
#  wind_velocity     :float(24)        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
