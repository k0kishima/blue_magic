class RacerCurrentSeriesPlacingRecordKpi < Kpi
  def value!
    validate!(:calculation)

    race_records = ::RaceRecord
                   .where(date: aggregation_range)
                   .where(stadium_tel_code: entry_object.race.stadium_tel_code)
                   .joins(:race_entry)
                   .merge(::RaceEntry.where(racer_registration_number: entry_object.racer_registration_number))

    if race_records.blank?
      raise DataNotFound,
            "cannot find data to calculate current series performance for #{entry_object.racer_registration_number}"
    end

    arrival_counts_indexed_by_start_data = race_records.group(:course_number,
                                                              :arrival).count.reduce({}) do |result, (key, value)|
      course_number, arrival = key
      result[course_number] ||= {}
      result[course_number][arrival] = value
      result
    end

    aggregations = arrival_counts_indexed_by_start_data.map do |course_number, counts|
      ::Aggregation.new(
        first_count: counts[1].to_i,
        second_count: counts[2].to_i,
        third_count: counts[3].to_i,
        forth_count: counts[4].to_i,
        fifth_count: counts[5].to_i,
        sixth_count: counts[6].to_i,
        unplaced_count: counts[nil].to_i
      )
    end

    calculate_strategy_class.new(aggregations).calculate
  end

  private

  def aggregation_range
    # NOTE: 算出の起点となるレースを含まないように注意
    aggregate_starts_at...aggregate_ends_at
  end

  def event
    raise DataNotPrepared if entry_object.race.event.blank?

    entry_object.race.event
  end

  def aggregate_starts_at
    @aggregate_starts_at ||= event.starts_on.to_datetime
  end

  def aggregate_ends_at
    @aggregate_ends_at ||= entry_object.race.betting_deadline_at
  end

  def calculate_strategy_class
    @calculate_strategy_class ||= case attribute_name
                                  when /average/
                                    AverageCalculator
                                  when /stdev/
                                    StdevCalculator
                                  else
                                    raise StandardError, "cannot apply any calculate strategy to key: #{attribute_name}"
                                  end
  end
end

class Aggregation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :first_count, :integer
  attribute :second_count, :integer
  attribute :third_count, :integer
  attribute :forth_count, :integer
  attribute :fifth_count, :integer
  attribute :sixth_count, :integer
  attribute :unplaced_count, :integer

  def total_count
    [first_count, second_count, third_count,
     forth_count, fifth_count, sixth_count,
     unplaced_count].map(&:to_i).sum
  end
end

class Calculator
  def initialize(aggregations)
    @aggregations = aggregations
  end

  private

  attr_reader :aggregations

  def samples
    @samples ||= -> do
      samples = []
      samples << Array.new(aggregations.map(&:first_count).sum, 1) unless aggregations.map(&:first_count).sum.zero?
      samples << Array.new(aggregations.map(&:second_count).sum, 2) unless aggregations.map(&:second_count).sum.zero?
      samples << Array.new(aggregations.map(&:third_count).sum, 3) unless aggregations.map(&:third_count).sum.zero?
      samples << Array.new(aggregations.map(&:forth_count).sum, 4) unless aggregations.map(&:forth_count).sum.zero?
      samples << Array.new(aggregations.map(&:fifth_count).sum, 5) unless aggregations.map(&:fifth_count).sum.zero?
      samples << Array.new(aggregations.map(&:sixth_count).sum, 6) unless aggregations.map(&:sixth_count).sum.zero?
      samples << Array.new(aggregations.map(&:unplaced_count).sum,
                           6) unless aggregations.map(&:unplaced_count).sum.zero?
      samples.flatten
    end.call
  end
end

class AverageCalculator < Calculator
  def calculate
    samples.sum / aggregations.map(&:total_count).sum.to_f
  end
end

class StdevCalculator < Calculator
  def calculate
    mean = samples.sum / aggregations.map(&:total_count).sum.to_f
    stdev = Math.sqrt(samples.reduce(0) { |a, b| a + (b - mean)**2 } / (samples.size - 1))
    stdev.nan? ? nil : stdev
  end
end
