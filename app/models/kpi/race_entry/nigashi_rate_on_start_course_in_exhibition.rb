module Kpi::RaceEntry
  class NigashiRateOnStartCourseInExhibition < AssistTrickKpi
    private

    def assist_winning_tricks
      [WinningTrick::Nige.instance]
    end

    def trick
      @trick ||= AssistTrick::Nigashi.instance
    end
  end
end
