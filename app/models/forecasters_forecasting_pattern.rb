class ForecastersForecastingPattern < ApplicationRecord
  belongs_to :forecaster
  belongs_to :forecasting_pattern

  validates :fund_allocation_method, presence: true, inclusion: { in: FundAllocationMethod.all }
  validates :budget_amount_per_race, presence: true
  validates :composition_odds, presence: true

  def target_amount
    budget_amount_per_race * composition_odds
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
