module Kpi::Stadium
  class MakurizashiSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makurizashi.instance
    end
  end
end
