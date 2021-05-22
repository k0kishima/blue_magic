module Kpi::RaceEntry
  class TrickKpi < Base
    AGGREGATION_YEARS = 1

    def aggregation_starts_on
      (offset_date - AGGREGATION_YEARS.years).prev_month.beginning_of_month
    end

    def aggregation_ends_on
      offset_date.prev_month.end_of_month
    end

    private

    def trick
      raise NotImplementedError
    end

    def check_data_preparation!
      return if subject.course_number_in_exhibition.present?
      raise DataNotPrepared, 'the source object does not have exhibition data yet' 
    end
  end
end
