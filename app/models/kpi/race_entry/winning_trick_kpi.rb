module Kpi::RaceEntry
  class WinningTrickKpi < Base
    def aggregate!(source:, aggregation_range:)
      Kpi::RaceEntry::WinningTrickKpiAggregator
        .new(
          kpi: self,
          trick: trick,
          aggregation_range: aggregation_range,
          source: source
        ).aggregate!
    end

    def trick_id = trick.id

    def trick
      raise NotImplementedError
    end
  end
end
