class Stadium < ApplicationRecord
  TELCODE_RANGE = 1..24

  self.table_name = :stadiums
  self.primary_key = :tel_code

  attr_accessor :aggregation_offset_date, :context

  enum water_quality: { fresh: 1, brackish: 2, sea: 3, }

  validates :tel_code, presence: true, inclusion: { in: TELCODE_RANGE }, uniqueness: true
  validates :name, presence: true
  validates :prefecture_id, presence: true, inclusion: { in: Prefecture.all.map(&:id) }
  validates :water_quality, presence: true
  validates :tide_fluctuation, inclusion: { in: [true, false] }
  validates :lat, presence: true
  validates :lng, presence: true
  validates :elevation, presence: true

  def self.all_tel_codes
    TELCODE_RANGE.to_a
  end

  def nige_succeed_rate_of_stadium_in_current_weather_condition
    @nige_succeed_rate_of_stadium_in_current_weather_condition ||= winning_trick_succeed_rate(WinningTrick::Nige.instance)
  end

  def sashi_succeed_rate_of_stadium_in_current_weather_condition
    @sashi_succeed_rate_of_stadium_in_current_weather_condition ||= winning_trick_succeed_rate(WinningTrick::Sashi.instance)
  end

  def makuri_succeed_rate_of_stadium_in_current_weather_condition
    @makuri_succeed_rate_of_stadium_in_current_weather_condition ||= winning_trick_succeed_rate(WinningTrick::Makuri.instance)
  end

  def makurizashi_succeed_rate_of_stadium_in_current_weather_condition
    @makurizashi_succeed_rate_of_stadium_in_current_weather_condition ||= winning_trick_succeed_rate(WinningTrick::Makurizashi.instance)
  end

  def sasare_rate_of_stadium_in_current_weather_condition
    @sasare_rate_of_stadium_in_current_weather_condition ||= assist_trick_succeed_rate(AssistTrick::Sasare.instance)
  end

  def makurare_rate_of_stadium_in_current_weather_condition
    @makurare_rate_of_stadium_in_current_weather_condition ||= assist_trick_succeed_rate(AssistTrick::Makurare.instance)
  end

  private

  def aggregation_range_of_recent_few_years
    @aggregation_range_of_recent_few_years ||= AggregationRangeFactory.create_to_aggregate_stadium_data_from(aggregation_offset_date)
  end

  def winning_trick_succeed_rate(trick)
    raise DataNotPrepared, 'the source object does not have context data yet' if aggregation_offset_date.blank? || context.blank?

    calculator = StadiumWinningTrickSucceedRateCalculator.new(trick: trick, stadium_tel_code: tel_code)
    calculator.calculate!(aggregation_range: aggregation_range_of_recent_few_years, context: context)
  end

  def assist_trick_succeed_rate(trick)
    raise DataNotPrepared, 'the source object does not have context data yet' if aggregation_offset_date.blank? || context.blank?

    calculator = StadiumAssistTrickSucceedRateCalculator.new(trick: trick, stadium_tel_code: tel_code)
    calculator.calculate!(aggregation_range: aggregation_range_of_recent_few_years, context: context)
  end
end

# == Schema Information
#
# Table name: stadiums
#
#  tel_code         :integer          not null, primary key
#  name             :string(255)      not null
#  prefecture_id    :integer          not null
#  water_quality    :integer          not null
#  tide_fluctuation :boolean          not null
#  lat              :float(24)        not null
#  lng              :float(24)        not null
#  elevation        :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
