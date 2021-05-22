module Kpi::RaceEntry
  class MakurizashiSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makurizashi.instance
    end
  end
end
