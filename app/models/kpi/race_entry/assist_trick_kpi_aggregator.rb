module Kpi::RaceEntry
  class AssistTrickKpiAggregator < TrickKpiAggregator
    validate :trick_must_be_a_assist_trick

    private

    def numerator
      @numerator ||= winners_in_racer_entered_races.select do |winner|
        winner.winning_trick_id.in?(kpi.assist_winning_trick_ids) && winner.race_record.course_number != course_number
      end.count
    end

    def trick_must_be_a_assist_trick
      return if trick.is_a?(AssistTrick)

      errors.add(:trick, 'trick must be a assist trick')
    end
  end
end
