module Kpi::Stadium
  class NigeSucceedRateInCurrentWeatherCondition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
