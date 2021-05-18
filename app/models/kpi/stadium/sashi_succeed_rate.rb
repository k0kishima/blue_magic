module Kpi::Stadium
  class SashiSucceedRate < WinningTrickKpi
    def key
      :sashi_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
