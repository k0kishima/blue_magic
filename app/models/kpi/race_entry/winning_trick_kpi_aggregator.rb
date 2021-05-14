module Kpi::RaceEntry
  class WinningTrickKpiAggregator < TrickKpiAggregator
    private

    def numerator
      winners_in_racer_entered_races.select do |winner|
        winner.winning_trick_id.in?(kpi.aggregatable_trick_ids) && winner.race_record.course_number.in?(course_number)
      end.count
    end
  end
end
