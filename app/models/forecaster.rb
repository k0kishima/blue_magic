class Forecaster < ApplicationRecord
  class AlreadyForecasted < StandardError; end

  has_many :forecasters_forecasting_patterns
  has_many :forecasting_patterns, through: :forecasters_forecasting_patterns
  has_many :recommend_odds, through: :forecasters_forecasting_patterns, class_name: 'RecommendOdds'

  enum status: { active: 1, simulating: 2 }
  enum betting_strategy: { take_the_first_forecasting_pattern: 1, take_all_forecasting_patterns: 2 }

  validates :name, presence: true
  validates :status, presence: true
  validates :betting_strategy, presence: true

  def self.current
    raise NotImplementedError
  end

  def forecast!(race)
    forecasters_forecasting_patterns.each do |forecasters_forecasting_pattern|
      forecasters_forecasting_pattern.create_recommend_odds_of!(race)
    end

    recommend_odds.where(**race.attributes.slice(*Race.primary_keys))
  rescue ActiveRecord::RecordNotUnique
    raise AlreadyForecasted
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id               :bigint           not null, primary key
#  status           :integer          not null
#  name             :string(255)      not null
#  description      :text(65535)
#  betting_strategy :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
