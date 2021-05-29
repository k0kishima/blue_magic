class StadiumWinningTrickKpi < Kpi
  AGGREGATION_YEARS = 99

  def value!
    validate!(:calculation)

    calculator = StadiumWinningTrickSucceedRateCalculator.new(trick: trick,
                                                              stadium_tel_code: entry_object.stadium_tel_code)
    calculator.calculate!(aggregation_range: aggregation_starts_on..aggregation_ends_on, context: context)
  end

  private

  def trick
    @trick ||= case attribute_name
               when /nige_succeed_rate/
                 WinningTrick::Nige.instance
               when /sashi_succeed_rate/
                 WinningTrick::Sashi.instance
               when /makuri_succeed_rate/
                 WinningTrick::Makuri.instance
               when /makurizashi_succeed_rate/
                 WinningTrick::Makurizashi.instance
               else
                 raise StandardError, "cannot assign a winning trick to key: #{attribute_name}"
               end
  end

  def offset_date
    entry_object.date
  end

  def aggregation_starts_on
    (offset_date - AGGREGATION_YEARS.years).prev_month.beginning_of_month
  end

  def aggregation_ends_on
    offset_date.prev_month.end_of_month
  end

  def context
    raise DataNotPrepared if entry_object.weather_condition_in_exhibition.blank?

    entry_object.weather_condition_in_exhibition.slice(:wind_angle, :wind_velocity)
  end
end
