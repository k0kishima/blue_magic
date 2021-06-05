class ForecastingPattern < ApplicationRecord
  validates :name, presence: true
  validates :race_filtering_condition, presence: true
  validates :first_place_filtering_condition, presence: true
  validates :second_place_filtering_condition, presence: true
  validates :third_place_filtering_condition, presence: true
  validates :odds_filtering_condition, presence: true

  def forecastable?(race)
    race_analysis = AnalysisFactory.create!(entry_object: race, filtering_condition: race_filtering_condition)
    expression = LogicalExpressionFactory.create!(race_filtering_condition)
    expression.call(Hashie::Mash.new(race_analysis))
  end

  def recommended_formation_of(race)
    filtered_race_entries = if forecastable?(race)
                              candicates(race.race_entries).map { |race_entries| race_entries.map(&:pit_number) }
                            else
                              [[], [], []]
                            end
    Formation.new(filtered_race_entries)
  end

  def recommend_odds_of(race)
    raise DataNotPrepared if race.odds.blank?

    formation = recommended_formation_of(race)
    return [] if formation.betting_numbers.blank?

    odds = race.odds.select { |o| o.betting_number.in?(formation.betting_numbers) }

    expression = LogicalExpressionFactory.create!(odds_filtering_condition)
    odds.select do |o|
      odds_analysis = AnalysisFactory.create!(entry_object: o, filtering_condition: odds_filtering_condition)
      expression.call(Hashie::Mash.new(odds_analysis))
    end
  end

  private

  def filtered_race_entries(race_entries:, where:)
    filtering_condition = try("#{where}_place_filtering_condition")
    expression = LogicalExpressionFactory.create!(filtering_condition)
    race_entries.select do |race_entry|
      race_entry_analysis = AnalysisFactory.create!(entry_object: race_entry, filtering_condition: filtering_condition)
      expression.call(Hashie::Mash.new(race_entry_analysis))
    end
  end

  def candicates(race_entries)
    %i[first second third].map do |place|
      filtered_race_entries(race_entries: race_entries, where: place)
    end
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
