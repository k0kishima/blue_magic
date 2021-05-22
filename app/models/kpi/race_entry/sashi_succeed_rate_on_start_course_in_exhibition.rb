module Kpi::RaceEntry
  class SashiSucceedRateOnStartCourseInExhibition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
