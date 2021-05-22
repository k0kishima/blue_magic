module Kpi::Stadium
  class SashiSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
