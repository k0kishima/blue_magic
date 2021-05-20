module Kpi::RaceEntry
  class SasareRate < AssistTrickKpi
    def key
      :sasare_rate
    end

    private

    def trick
      @trick ||= AssistTrick::Sasare.instance
    end
  end
end
