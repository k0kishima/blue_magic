class ForecastingPattern < ApplicationRecord
  validates :name, presence: true
  validates :race_filtering_condition, presence: true
  validates :first_place_filtering_condition, presence: true
  validates :second_place_filtering_condition, presence: true
  validates :third_place_filtering_condition, presence: true
  validates :odds_filtering_condition, presence: true

  def match?(race)
    race_analysis = kpis_to_filter_race.map do |kpi|
      kpi.entry_object = race
      [kpi.key, kpi.value!]
    end.to_h
    expression = LogicalExpressionFactory.create!(race_filtering_condition)
    expression.call(Hashie::Mash.new(race_analysis))
  end

  def recommended_formation(race)
    Formation.new(candicates(race.race_entries).map { |race_entries| race_entries.map(&:pit_number) })
  end

  def recommend_odds(race)
    return [] unless match?(race)

    formation = recommended_formation(race)
    return [] if formation.betting_numbers.blank?

    odds = race.odds.select { |o| o.betting_number.in?(formation.betting_numbers) }

    expression = LogicalExpressionFactory.create!(odds_filtering_condition)

    odds = odds.select do |o|
      odds_analysis = kpis_to_filter_odds.map do |kpi|
        kpi.entry_object = o
        [kpi.key, kpi.value!]
      end.to_h
      expression.call(Hashie::Mash.new(odds_analysis))
    end

    odds.each { |o| o.forecasting_pattern_id = id }

    odds
  end

  private

  def kpis_to_filter_race
    @kpis_to_filter_race ||= KpiFactory.create_recursively!(entry_object_class_name: 'Race',
                                                            hash: race_filtering_condition)
  end

  def kpis_to_filter_odds
    @kpis_to_filter_odds ||= KpiFactory.create_recursively!(entry_object_class_name: 'Odds',
                                                            hash: odds_filtering_condition)
  end

  def filtered_race_entries(race_entries:, where:)
    kpis = KpiFactory.create_recursively!(entry_object_class_name: 'RaceEntry',
                                          hash: try("#{where}_place_filtering_condition"))
    expression = LogicalExpressionFactory.create!(try("#{where}_place_filtering_condition"))
    race_entries.select do |race_entry|
      race_entry_analysis = kpis.map do |kpi|
        kpi.entry_object = race_entry
        [kpi.key, kpi.value!]
      end.to_h
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
