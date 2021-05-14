module Kpi::RaceEntry
  class TrickKpiAggregator
    def initialize(kpi:, trick:, aggregation_range:, source:)
      @kpi = kpi
      @trick = trick
      @aggregation_range = aggregation_range
      @source = source
    end

    def aggregate
      ::Kpi::Aggregation.new(
        kpi: kpi,
        value: Rational(numerator, denominator).to_f,
        aggregate_starts_on: aggregate_starts_on,
        aggregate_ends_on: aggregate_ends_on,
      )
    end

    private

    attr_reader :kpi, :trick, :aggregation_range, :source

    def aggregate_starts_on
      aggregation_range.first
    end

    def aggregate_ends_on
      aggregation_range.last
    end

    def course_number
      trick.available_course_numbers
    end

    def racer_registration_number
      source.racer_registration_number
    end

    def racer_on_specified_course_records
      # 枠番じゃなくて本番の進入コースが基準なので注意
      @racer_on_specified_course_records ||=
        RaceRecord
        .joins(:race_entry)
        .where(course_number: course_number)
        .where(date: aggregate_starts_on..aggregate_ends_on)
        .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
    end

    def denominator
      @denominator ||= racer_on_specified_course_records.count
    end

    def racer_entered_races
      @racer_entered_races ||=
        racer_on_specified_course_records
        .includes(race_entry: { race: { race_entries: { race_record: :winning_race_entry } } })
        .map { |race_record| race_record.race_entry.race }
        .compact
    end

    def winners_in_racer_entered_races
      @winners_in_racer_entered_races ||=
        racer_entered_races.reject { |race|
          race.winner.blank?
        }.map { |race| race.winner }
    end

    def numerator
      raise NotImplementedError
    end
  end
end
