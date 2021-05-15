module Kpi::RaceEntry
  class SashiSucceedRate < Base
    include WinningTrickKpiAggregatable

    def key
      :sashi_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
