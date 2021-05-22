module Kpi::RaceEntry
  class SashiSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
