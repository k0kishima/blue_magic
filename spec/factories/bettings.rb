FactoryBot.define do
  factory :betting do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    betting_number { 123 }
    betting_method { :trifecta }
    betting_amount { 10_000 }
    voted_at { Time.zone.now }
    dry_run { true }

    trait :with_forecasters_forecasting_pattern do
      association :forecasters_forecasting_pattern, factory: :forecasters_forecasting_pattern
    end
  end
end

# == Schema Information
#
# Table name: bettings
#
#  forecasters_forecasting_pattern_id :bigint           not null, primary key
#  stadium_tel_code                   :integer          not null, primary key
#  date                               :date             not null, primary key
#  race_number                        :integer          not null, primary key
#  betting_method                     :integer          not null
#  betting_number                     :integer          not null, primary key
#  betting_amount                     :integer          not null
#  refunded_amount                    :integer
#  adjustment_amount                  :integer
#  dry_run                            :boolean          not null
#  voted_at                           :datetime         not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
# Indexes
#
#  foreign_key_1  (forecasters_forecasting_pattern_id)
#
# Foreign Keys
#
#  fk_rails_...  (forecasters_forecasting_pattern_id => forecasters_forecasting_patterns.id)
#
