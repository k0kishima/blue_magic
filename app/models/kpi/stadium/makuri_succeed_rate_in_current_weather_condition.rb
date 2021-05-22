module Kpi::Stadium
  class MakuriSucceedRateInCurrentWeatherCondition < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makuri.instance
    end
  end
end
