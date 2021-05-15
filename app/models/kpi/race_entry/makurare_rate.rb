module Kpi::RaceEntry
  class MakurareRate < Base
    include AssistTrickKpiAggregatable

    def key
      :makurare_rate
    end

    private

    def assist_winning_tricks
      [WinningTrick::Makuri.instance]
    end

    def trick
      @trick ||= AssistTrick::Makurare.instance
    end
  end
end
