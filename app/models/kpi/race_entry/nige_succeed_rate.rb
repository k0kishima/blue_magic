module Kpi::RaceEntry
  class NigeSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
