FactoryBot.define do
  factory :boat_betting_contribute_rate_aggregation do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:boat_number) {|n| n }
    aggregated_on { Time.zone.today }
    sequence(:quinella_rate, (10..80).step(10).to_a.cycle)
    sequence(:trio_rate, (20..90).step(10).to_a.cycle)
  end
end

# == Schema Information
#
# Table name: boat_betting_contribute_rate_aggregations
#
#  aggregated_on    :date             not null, primary key
#  boat_number      :integer          not null, primary key
#  quinella_rate    :float(24)        not null
#  stadium_tel_code :integer          not null, primary key
#  trio_rate        :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
