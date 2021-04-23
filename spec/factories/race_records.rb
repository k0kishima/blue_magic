FactoryBot.define do
  factory :race_record do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    sequence(:pit_number, (Pit::NUMBER_RANGE).to_a.cycle)
    sequence(:course_number, (Pit::NUMBER_RANGE).to_a.cycle)
    sequence(:start_order, (Pit::NUMBER_RANGE).to_a.cycle)
    sequence(:arrival, (Pit::NUMBER_RANGE).to_a.cycle)
  end
end

# == Schema Information
#
# Table name: race_records
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  course_number    :integer          not null
#  start_time       :float(24)
#  start_order      :integer
#  race_time        :float(24)
#  arrival          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
