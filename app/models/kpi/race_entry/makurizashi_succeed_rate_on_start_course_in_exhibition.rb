module Kpi::RaceEntry
  class MakurizashiSucceedRateOnStartCourseInExhibition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makurizashi.instance
    end
  end
end
