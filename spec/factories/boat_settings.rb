FactoryBot.define do
  factory :boat_setting do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    sequence(:pit_number, Pit::NUMBER_RANGE.to_a.cycle)
    sequence(:boat_number) {|n| n }
    sequence(:motor_number) {|n| n }
    sequence(:tilt, (-0.5..3.0).step(0.5).to_a.cycle)
    propeller_renewed { false }
  end
end

# == Schema Information
#
# Table name: boat_settings
#
#  stadium_tel_code  :integer          not null, primary key
#  date              :date             not null, primary key
#  race_number       :integer          not null, primary key
#  pit_number        :integer          not null, primary key
#  boat_number       :integer          not null
#  motor_number      :integer          not null
#  tilt              :float(24)        not null
#  propeller_renewed :boolean          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,boat_number) UNIQUE
#  uniq_index_2  (stadium_tel_code,date,race_number,motor_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
