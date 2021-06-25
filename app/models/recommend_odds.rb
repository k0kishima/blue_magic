class RecommendOdds < ApplicationRecord
  include RaceAssociating
  include BettingMethodSelector

  self.table_name = :recommend_odds
  self.primary_keys = %i[forecasters_forecasting_pattern_id stadium_tel_code date race_number betting_number]

  belongs_to :forecasters_forecasting_pattern
  has_one :betting, foreign_key: self.primary_keys, dependent: :destroy

  validates :ratio_when_forecasting, presence: true
  validates :should_purchase_quantity, presence: true
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
#  betting_number                     :integer          not null
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
