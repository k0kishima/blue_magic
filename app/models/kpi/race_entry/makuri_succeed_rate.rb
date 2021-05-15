module Kpi::RaceEntry
  class MakuriSucceedRate < Base
    include WinningTrickKpiAggregatable

    def key
      :makuri_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Makuri.instance
    end
  end
end
