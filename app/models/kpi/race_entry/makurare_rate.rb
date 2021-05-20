module Kpi::RaceEntry
  class MakurareRate < AssistTrickKpi
    def key
      :makurare_rate
    end

    private

    def trick
      @trick ||= AssistTrick::Makurare.instance
    end
  end
end
