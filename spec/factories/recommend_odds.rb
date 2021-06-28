FactoryBot.define do
  factory :recommend_odds do
    date { Time.zone.today }
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    sequence(:race_number, Race.numbers.cycle)
    betting_number { 123 }
    betting_method { :trifecta }
    ratio_when_forecasting { 10.5 }
    should_purchase_quantity { 20 }

    trait :with_forecasters_forecasting_pattern do
      association :forecasters_forecasting_pattern, factory: :forecasters_forecasting_pattern
    end

    trait :with_betting do
      after(:create) do |recommend_odds|
        create(:betting, recommend_odds.attributes.slice(*RecommendOdds.primary_keys))
      end
    end
  end
end

# == Schema Information
#
# Table name: recommend_odds
#
#  forecasters_forecasting_pattern_id :bigint           not null, primary key
#  stadium_tel_code                   :integer          not null, primary key
#  date                               :date             not null, primary key
#  race_number                        :integer          not null, primary key
#  betting_method                     :integer          not null
#  betting_number                     :integer          not null, primary key
#  ratio_when_forecasting             :float(24)        not null
#  should_purchase_quantity           :integer          not null
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
