module Kpi::RaceEntry
  class MakurizashiSucceedRate < WinningTrickKpi
    def key
      :makurizashi_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Makurizashi.instance
    end
  end
end
