module Kpi::RaceEntry
  class WinningTrickKpiAggregator < TrickKpiAggregator
    validate :trick_must_be_a_winning_trick

    private

    def numerator
      winners_in_racer_entered_races.select do |winner|
        winner.winning_trick_id == kpi.trick_id && winner.race_record.course_number.in?(course_number)
      end.count
    end

    def trick_must_be_a_winning_trick
      return if trick.is_a?(WinningTrick)

      errors.add(:trick, 'trick must be a winning trick')
    end
  end
end
