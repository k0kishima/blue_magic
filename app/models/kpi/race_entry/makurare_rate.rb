module Kpi::RaceEntry
  class MakurareRate < AssistTrickKpi
    private

    def trick
      @trick ||= AssistTrick::Makurare.instance
    end
  end
end
