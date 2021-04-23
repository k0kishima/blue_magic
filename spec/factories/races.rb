FactoryBot.define do
  factory :race do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    title { '一般競走' }
    number_of_laps { 3 }
    course_fixed { true }
    use_stabilizer { true }
    betting_deadline_at { date.to_datetime }

    trait :with_race_entries do
      after(:create) do |race|
        create_list(:race_entry, 6, race.attributes.slice(*Race.primary_keys))
      end
    end
  end
end

# == Schema Information
#
# Table name: races
#
#  stadium_tel_code    :integer          not null, primary key
#  date                :date             not null, primary key
#  race_number         :integer          not null, primary key
#  title               :string(255)      not null
#  course_fixed        :boolean          default(FALSE), not null
#  use_stabilizer      :boolean          default(FALSE), not null
#  number_of_laps      :integer          default(3), not null
#  betting_deadline_at :datetime         not null
#  canceled            :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_races_on_betting_deadline_at  (betting_deadline_at)
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
