FactoryBot.define do
  factory :winning_race_entry do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    sequence(:pit_number, Pit::NUMBER_RANGE.to_a.cycle)
    winning_trick { ::WinningTrick::ID::NUKI }
  end
end

# == Schema Information
#
# Table name: winning_race_entries
#
#  date             :date             not null, primary key
#  pit_number       :integer          not null, primary key
#  race_number      :integer          not null, primary key
#  stadium_tel_code :integer          not null, primary key
#  winning_trick    :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
