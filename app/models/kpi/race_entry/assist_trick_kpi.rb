module Kpi::RaceEntry
  class AssistTrickKpi < Base
    def aggregate!(source:, aggregation_range:)
      raise ArgumentError, "#{source.class} cannot aggregate as #{self.class.name}" unless source.is_a?(subject)

      raise DataNotPrepared,
            'the source object does not have exhibition data yet' if source.course_number_in_exhibition.blank?

      calculator = RacerAssistTrickSucceedRateCalculator.new(
        racer_registration_number: source.racer_registration_number,
        course_number: source.course_number_in_exhibition,
        trick: trick
      )

      ::Kpi::Aggregation.new(
        kpi: self,
        value: calculator.calculate!(aggregation_range: aggregation_range),
        aggregate_starts_on: aggregation_range.first,
        aggregate_ends_on: aggregation_range.last,
      )
    end
  end
end
