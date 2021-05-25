class ForecastingPattern < ApplicationRecord
  validates :name, presence: true
  validates :race_filtering_condition, presence: true
  validates :first_place_filtering_condition, presence: true
  validates :second_place_filtering_condition, presence: true
  validates :third_place_filtering_condition, presence: true
  validates :odds_filtering_condition, presence: true

  def match?(race)
    race_analysis = Analysis::RaceFactory.create!(race, *kpis_to_filter_race)
    expression = LogicalExpressionFactory.create!(race_filtering_condition)
    expression.call(race_analysis)
  end

  private

  def kpis_to_filter_race
    @kpis_to_filter_race ||= Kpi::Factory.create_recursively!(race_filtering_condition)
  end
end

# == Schema Information
#
# Table name: forecasting_patterns
#
#  id                               :bigint           not null, primary key
#  name                             :string(255)      not null
#  description                      :text(65535)
#  race_filtering_condition         :json             not null
#  first_place_filtering_condition  :json             not null
#  second_place_filtering_condition :json             not null
#  third_place_filtering_condition  :json             not null
#  odds_filtering_condition         :json             not null
#  frozen_at                        :datetime
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
