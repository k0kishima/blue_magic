module Kpi::Stadium
  class WinningTrickKpi < Base
    AGGREGATION_YEARS = 10

    def value!
      validate!

      calculator = StadiumWinningTrickSucceedRateCalculator.new(stadium_tel_code: subject.tel_code, trick: trick)
      calculator.calculate!(aggregation_range: aggregation_starts_on..aggregation_ends_on, context: context)
    end

    def aggregation_starts_on
      (offset_date - AGGREGATION_YEARS.years).prev_month.beginning_of_month
    end

    def aggregation_ends_on
      offset_date.prev_month.end_of_month
    end

    private

    def context
      raise DataNotPrepared if source.weather_condition_in_exhibition.blank?

      source.weather_condition_in_exhibition.slice(:wind_angle, :wind_velocity)
    end

    def trick
      raise NotImplementedError
    end
  end
end
