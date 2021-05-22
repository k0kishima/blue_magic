module Kpi::RaceEntry
  class MakuriSucceedRateOnStartCourseInExhibition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makuri.instance
    end
  end
end
