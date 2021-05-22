module Kpi::Stadium
  class NigeSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
