module AssistTrickKpiAggregatable
  extend ActiveSupport::Concern

  included do
    def aggregate!(source:, aggregation_range:)
      Kpi::RaceEntry::AssistTrickKpiAggregator
        .new(
          kpi: self,
          trick: trick,
          aggregation_range: aggregation_range,
          source: source
        ).aggregate!
    end

    def winning_trick_ids
      raise NotImplementedError
    end

    private

    def trick
      raise NotImplementedError
    end
  end
end
