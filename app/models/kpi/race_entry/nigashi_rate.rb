module Kpi::RaceEntry
  class NigashiRate < AssistTrickKpi
    def key
      :nigashi_rate
    end

    private

    def assist_winning_tricks
      [WinningTrick::Nige.instance]
    end

    def trick
      @trick ||= AssistTrick::Nigashi.instance
    end
  end
end
