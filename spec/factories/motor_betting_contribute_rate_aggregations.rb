FactoryBot.define do
  factory :motor_betting_contribute_rate_aggregation do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:motor_number) { |n| n }
    aggregated_on { Time.zone.today }
    sequence(:quinella_rate, (10..80).step(10).to_a.cycle)
    sequence(:trio_rate, (20..90).step(10).to_a.cycle)
  end
end

# == Schema Information
#
# Table name: motor_betting_contribute_rate_aggregations
#
#  stadium_tel_code :integer          not null, primary key
#  motor_number     :integer          not null, primary key
#  aggregated_on    :date             not null, primary key
#  quinella_rate    :float(24)        not null
#  trio_rate        :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
