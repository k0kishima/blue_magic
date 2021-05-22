module Kpi::RaceEntry
  class WinningTrickKpi < TrickKpi
    def value!
      check_data_preparation!

      calculator = RacerWinningTrickSucceedRateCalculator.new(
        racer_registration_number: subject.racer_registration_number,
        course_number: subject.course_number_in_exhibition,
        trick: trick
      )

      calculator.calculate!(aggregation_range: aggregation_starts_on..aggregation_ends_on)
    end
  end
end
