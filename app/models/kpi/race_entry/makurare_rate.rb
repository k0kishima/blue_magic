module Kpi::RaceEntry
  class MakurareRate < AssistTrickKpi
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
