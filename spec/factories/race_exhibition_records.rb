FactoryBot.define do
  factory :race_exhibition_record do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    sequence(:pit_number, (Pit::NUMBER_RANGE).to_a.cycle)
    sequence(:course_number, (Pit::NUMBER_RANGE).to_a.cycle)
    start_time { 0.15 }
    exhibition_time { 6.82 }
    sequence(:exhibition_time_order, (Pit::NUMBER_RANGE).to_a.cycle)
  end
end

# == Schema Information
#
# Table name: race_exhibition_records
#
#  stadium_tel_code      :integer          not null, primary key
#  date                  :date             not null, primary key
#  race_number           :integer          not null, primary key
#  pit_number            :integer          not null, primary key
#  course_number         :integer          not null
#  start_time            :float(24)        not null
#  exhibition_time       :float(24)        not null
#  exhibition_time_order :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
