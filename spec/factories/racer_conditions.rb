FactoryBot.define do
  factory :racer_condition do
    date { Time.zone.today }
    sequence(:racer_registration_number){|n| n}
    weight { 51.0 }
    adjust { 0 }
  end
end

# == Schema Information
#
# Table name: racer_conditions
#
#  racer_registration_number :integer          not null, primary key
#  date                      :date             not null, primary key
#  weight                    :float(24)        not null
#  adjust                    :float(24)        not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
