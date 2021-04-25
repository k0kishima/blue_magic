FactoryBot.define do
  factory :racer_winning_rate_aggregation do
    sequence(:racer_registration_number) { |n| n }
    sequence(:rate_in_all_stadium, (1.0..9.5).step(0.5).to_a.cycle)
    sequence(:rate_in_event_going_stadium, (1.0..9.5).step(0.5).to_a.cycle)
    aggregated_on { Time.zone.today }
  end
end

# == Schema Information
#
# Table name: racer_winning_rate_aggregations
#
#  racer_registration_number   :integer          not null, primary key
#  aggregated_on               :date             not null, primary key
#  rate_in_all_stadium         :float(24)        not null
#  rate_in_event_going_stadium :float(24)        not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
