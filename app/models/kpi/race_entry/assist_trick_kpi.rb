module Kpi::RaceEntry
  class AssistTrickKpi < Base
    def aggregate!(source:, aggregation_range:)
      Kpi::RaceEntry::AssistTrickKpiAggregator
        .new(
          kpi: self,
          trick: trick,
          aggregation_range: aggregation_range,
          source: source
        ).aggregate!
    end

    def assist_winning_trick_ids
      assist_winning_tricks.map(&:id)
    end

    private

    def assist_winning_tricks
      raise NotImplementedError
    end

    def trick
      raise NotImplementedError
    end
  end
end
