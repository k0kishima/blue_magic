module Kpi::RaceEntry
  class SasareRate < Base
    include AssistTrickKpiAggregatable

    def key
      :sasare_rate
    end

    def assist_winning_trick_ids
      assist_winning_tricks.map(&:id)
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
