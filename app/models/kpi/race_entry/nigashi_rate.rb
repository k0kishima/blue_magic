module Kpi::RaceEntry
  class NigashiRate < AssistTrickKpi
    private

    def assist_winning_tricks
      [WinningTrick::Nige.instance]
    end

    def trick
      @trick ||= AssistTrick::Nigashi.instance
    end
  end
end
