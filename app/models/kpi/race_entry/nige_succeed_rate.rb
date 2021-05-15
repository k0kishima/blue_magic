module Kpi::RaceEntry
  class NigeSucceedRate < Base
    include WinningTrickKpiAggregatable

    def key
      :nige_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Nige.instance
    end
  end
end
