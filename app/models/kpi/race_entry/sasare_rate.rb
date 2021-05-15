module Kpi::RaceEntry
  class SasareRate < Base
    include AssistTrickKpiAggregatable

    def key
      :sasare_rate
    end

    private

    def assist_winning_tricks
      [WinningTrick::Sashi.instance, WinningTrick::Makurizashi.instance]
    end

    def trick
      @trick ||= AssistTrick::Sasare.instance
    end
  end
end
