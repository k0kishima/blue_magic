module Kpi::RaceEntry
  class MakurareRateOnStartCourseInExhibition < AssistTrickKpi
    private

    def trick
      @trick ||= AssistTrick::Makurare.instance
    end
  end
end
