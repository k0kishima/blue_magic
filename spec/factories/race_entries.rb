FactoryBot.define do
  factory :race_entry do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    sequence(:racer_registration_number){|n| n}
    sequence(:pit_number, (Pit::NUMBER_RANGE).to_a.cycle)
  end
end

# == Schema Information
#
# Table name: race_entries
#
#  stadium_tel_code          :integer          not null, primary key
#  date                      :date             not null, primary key
#  race_number               :integer          not null, primary key
#  racer_registration_number :integer          not null
#  pit_number                :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,racer_registration_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
