module Kpi::Stadium
  class NigeSucceedRate < WinningTrickKpi
    def key
      :nige_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
