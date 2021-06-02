class ForecastersForecastingPattern < ApplicationRecord
  belongs_to :forecaster
  belongs_to :forecasting_pattern
  has_many :recommend_odds, class_name: 'RecommendOdds'

  validates :fund_allocation_method, presence: true, inclusion: { in: FundAllocationMethod.all }
  validates :budget_amount_per_race, presence: true
  validates :composition_odds, presence: true

  def target_amount
    budget_amount_per_race * composition_odds
  end

  def create_recommend_odds_of!(race)
    odds = forecasting_pattern.recommend_odds_of(race)

    should_purchase_quantities_indexed_by_betting_number = FundAllocationService.call(
      budget_amount: budget_amount_per_race,
      target_amount: target_amount,
      odds: odds,
      fund_allocation_method: fund_allocation_method
    )

    recommend_odds_collection = odds.map do |o|
      should_purchase_quantity = should_purchase_quantities_indexed_by_betting_number[o.betting_number]
      if should_purchase_quantity.present?
        recommend_odds.build(
          **race.attributes.slice(*Race.primary_keys),
          betting_method: o.betting_method,
          betting_number: o.betting_number,
          ratio_when_forecasting: o.ratio,
          should_purchase_quantity: should_purchase_quantity
        )
      else
        nil
      end
    end.compact

    RecommendOdds.import!(recommend_odds_collection, all_or_none: true, raise_error: true, validate_uniqueness: true)
  rescue OverBudget
    []
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
