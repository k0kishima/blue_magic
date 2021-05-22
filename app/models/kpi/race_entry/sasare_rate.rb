module Kpi::RaceEntry
  class SasareRate < AssistTrickKpi
    private

    def trick
      @trick ||= AssistTrick::Sasare.instance
    end
  end
end
