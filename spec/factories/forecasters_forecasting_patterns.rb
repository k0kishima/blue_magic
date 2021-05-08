FactoryBot.define do
  factory :forecasters_forecasting_pattern do
    forecaster
    forecasting_pattern
    budget_amount_per_race { 10_000 }
    fund_allocation_method { FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET }
    composition_odds { 8.0 }
  end
end

# == Schema Information
#
# Table name: forecasters_forecasting_patterns
#
#  id                     :bigint           not null, primary key
#  forecaster_id          :bigint
#  forecasting_pattern_id :bigint
#  budget_amount_per_race :integer          not null
#  fund_allocation_method :integer          not null
#  composition_odds       :float(24)        not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  foreign_key_1  (forecaster_id)
#  foreign_key_2  (forecasting_pattern_id)
#  uniq_index_1   (forecaster_id,forecasting_pattern_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (forecaster_id => forecasters.id)
#  fk_rails_...  (forecasting_pattern_id => forecasting_patterns.id)
#
