class ForecastingPattern < ApplicationRecord
  validates :name, presence: true
  validates :race_select_condition, presence: true
  validates :first_place_select_condition, presence: true
  validates :second_place_select_condition, presence: true
  validates :third_place_select_condition, presence: true
  validates :odds_select_condition, presence: true

  def forecastable?(race)
    expression = LogicalExpressionFactory.create!(race_select_condition)
    expression.call(race.analysis)
  end

  def recommended_formation_of(race)
    selected_pit_numbers = if forecastable?(race)
                              Rails.application.config.betting_logger.info("#{race.ids} by fpid #{id}: forecastable".green)
                              candicates(race.race_entries_analysis).map { |race_entries| race_entries.map(&:pit_number) }
                            else
                              Rails.application.config.betting_logger.info("#{race.ids} by fpid #{id}: is not forecastable")
                              [[], [], []]
                            end
    Formation.new(selected_pit_numbers)
  end

  def recommend_odds_of(race)
    raise DataNotPrepared if race.odds.blank?

    formation = recommended_formation_of(race)
    return [] if formation.betting_numbers.blank?

    odds = race.odds.select { |o| o.betting_number.in?(formation.betting_numbers) }

    expression = LogicalExpressionFactory.create!(odds_select_condition)
    odds.select do |o|
      o.race = race.analysis
      odds_analysis = AnalysisFactory.create!(entry_object: o, select_condition: odds_select_condition)
      expression.call(Hashie::Mash.new(odds_analysis))
    end
  end

  private

  def filtered_race_entries(race_entries:, where:)
    select_condition = try("#{where}_place_select_condition")
    expression = LogicalExpressionFactory.create!(select_condition)
    selected_race_entries = race_entries.select { |race_entry| expression.call(race_entry) }

    if selected_race_entries.present?
      Rails.application.config.betting_logger.info("\tfpid #{id}: succeeded to select race entries as #{where} place".green)
    else
      Rails.application.config.betting_logger.info("\tby fpid #{id}: could not select race entries as #{where} place")
    end
    selected_race_entries
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
#  id                            :bigint           not null, primary key
#  name                          :string(255)      not null
#  description                   :text(65535)
#  race_select_condition         :json             not null
#  first_place_select_condition  :json             not null
#  second_place_select_condition :json             not null
#  third_place_select_condition  :json             not null
#  odds_select_condition         :json             not null
#  frozen_at                     :datetime
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
