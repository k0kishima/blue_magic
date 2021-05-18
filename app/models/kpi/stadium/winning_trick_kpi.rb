module Kpi::Stadium
  class WinningTrickKpi < Base
    def aggregate!(stadium_tel_code:, course_number:, aggregation_range:, context:)
      calculator = StadiumWinningTrickSucceedRateCalculator.new(stadium_tel_code: stadium_tel_code,
                                                                course_number: course_number, trick: trick)

      ::Kpi::Aggregation.new(
        kpi: self,
        value: calculator.calculate!(aggregation_range: aggregation_range, context: context),
        aggregate_starts_on: aggregation_range.first,
        aggregate_ends_on: aggregation_range.last,
      )
    end

    private

    def trick
      raise NotImplementedError
    end
  end
end
