module Kpi::Stadium
  class MakurizashiSucceedRateInCurrentWeatherCondition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makurizashi.instance
    end
  end
end
