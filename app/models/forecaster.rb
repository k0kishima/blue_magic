class Forecaster < ApplicationRecord
  class AlreadyForecasted < StandardError; end

  has_many :forecasters_forecasting_patterns, dependent: :destroy
  has_many :forecasting_patterns, through: :forecasters_forecasting_patterns
  has_many :recommend_odds, through: :forecasters_forecasting_patterns, class_name: 'RecommendOdds'

  enum status: { active: 1, simulating: 2 }
  enum betting_strategy: { take_the_first_forecasting_pattern: 1, take_all_forecasting_patterns: 2,
                           take_all_forecasting_patterns_without_duplication: 3 }

  validates :name, presence: true
  validates :status, presence: true
  validates :betting_strategy, presence: true

  def self.current
    # todo: 正式に実装する
    # というより1つしか選べないのは不便な気もするのでこのメソッドの存在意義も再考する
    first
  end

  def forecast!(race)
    forecasters_forecasting_patterns.each do |forecasters_forecasting_pattern|
      begin
        forecasters_forecasting_pattern.create_recommend_odds_of!(race)
      rescue ActiveModel::ValidationError, DataNotFound, DataNotPrepared => e
        Rails.application.config.betting_logger.warn("#{race.ids} by fpid #{forecasters_forecasting_pattern.forecasting_pattern_id}: #{e.message}")
        next
      rescue ActiveRecord::RecordNotUnique
        Rails.application.config.betting_logger.warn("#{race.ids} by fpid #{forecasters_forecasting_pattern.forecasting_pattern_id}: is skipped because already forecasted")
        next
      end
    end

    recommend_odds.where(**race.attributes.slice(*Race.primary_keys))
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
#  betting_strategy :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
