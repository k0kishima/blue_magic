FactoryBot.define do
  factory :odds do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    betting_number { 123 }
    betting_method { :trifecta }
    ratio { 10.5 }
  end
end

# == Schema Information
#
# Table name: odds
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  ratio            :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
