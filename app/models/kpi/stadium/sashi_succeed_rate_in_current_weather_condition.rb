module Kpi::Stadium
  class SashiSucceedRateInCurrentWeatherCondition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Sashi.instance
    end
  end
end
