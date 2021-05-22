module Kpi::RaceEntry
  class NigeSucceedRateOnStartCourseInExhibition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
