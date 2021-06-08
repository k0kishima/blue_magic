class RacerPlacingRecordKpi < Kpi
  AGGREGATION_YEARS = 1

  def value!
    validate!(:calculation)
    check_data_preparation!

    # 期間内のみ集計されること
    # 指定されたコースでのみ集計されること(※枠番じゃなくて本番の進入コースが基準)
    # 対象のレーサーのみ集計されること
    # 出走記録がない場合（例えば欠場など）は集計されないこと
    race_records =  ::RaceRecord
                        .where(date: aggregation_starts_on..aggregation_ends_on)
                        .where(course_number: entry_object.course_number_in_exhibition)
                        .joins(:race_entry)
                        .merge(::RaceEntry.where(racer_registration_number: entry_object.racer_registration_number))
    counts_indexed_by_arrival = race_records.group(:arrival).count

    begin
      Rational(counts_indexed_by_arrival[arrival], counts_indexed_by_arrival.values.sum)
    rescue ZeroDivisionError
      0
    end
  end

  def arrival
    @arrival ||= case attribute_name
               when /first_place/
                 1
               when /second_place/
                 2
               when /third_place/
                 3
               else
                 raise StandardError, "cannot apply a placing to key: #{attribute_name}"
               end
  end

  private

  def offset_date
    entry_object.race.date
  end

  def aggregation_starts_on
    (offset_date - AGGREGATION_YEARS.years).beginning_of_month
  end

  def aggregation_ends_on
    offset_date.prev_month.end_of_month
  end

  def check_data_preparation!
    return if entry_object.course_number_in_exhibition.present?

    raise DataNotPrepared, 'the source object does not have exhibition data yet'
  end
end
