class RacerStartTimeKpi < Kpi
  def value!
    validate!(:calculation)

    race_records = ::RaceRecord
                   .joins(race_entry: :race)
                   .merge(::RaceEntry.where(racer_registration_number: entry_object.racer_registration_number))
                   .merge(Race.where(betting_deadline_at: aggregation_range))

    if race_records.blank?
      raise DataNotFound,
            "cannot find data to calculate st performance for #{entry_object.racer_registration_number}"
    end

    race_records.map(&:start_time).reject(&:blank?).try(calculate_method)
  end

  private

  def racer_registration_number
    @racer_registration_number ||= entry_object.racer_registration_number
  end

  def aggregation_range
    @aggregation_range ||= case attribute_name
                           when /in_current_rating_term/
                             entry_object.race.range_for_current_racer_rating_evaluation_term_aggregation
                           when /in_current_series/
                             entry_object.race.range_for_current_series_aggregation
                           else
                             raise StandardError, "cannot decide aggregation range to key: #{attribute_name}"
                           end
  end
end

def calculate_method
  @calculate_method ||= case attribute_name
                        when /average/
                          :mean
                        when /stdev/
                          :sd
                        else
                          raise StandardError, "cannot apply any calculate method to key: #{attribute_name}"
                        end
end
