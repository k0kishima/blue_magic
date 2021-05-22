module Kpi::RaceEntry
  class SasareRateOnStartCourseInExhibition < AssistTrickKpi
    private

    def trick
      @trick ||= AssistTrick::Sasare.instance
    end
  end
end
