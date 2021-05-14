module Kpi::RaceEntry
  class NigeSucceedRate < Base
    def key
      :nige_succeed_rate
    end

    def aggregatable_trick_ids
      [WinningTrick::ID::NIGE]
    end
  end
end
