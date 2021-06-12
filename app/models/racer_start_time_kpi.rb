class RacerStartTimeKpi < Kpi
  def value!
    validate!(:calculation)

    race_records = ::RaceRecord
                   .joins(race_entry: :race)
                   .merge(::RaceEntry.where(racer_registration_number: entry_object.racer_registration_number))
                   .merge(Race.where(betting_deadline_at: aggregation_range.value))

    raise DataNotFound if race_records.blank?

    race_records.map(&:start_time).reject(&:blank?).try(calculate_method)
  end

  private

  def racer_registration_number
    @racer_registration_number ||= entry_object.racer_registration_number
  end

  def aggregation_range
    @aggregation_range ||= case attribute_name
                           when /in_current_term/
                             CurrentTerm.new(entry_object.race)
                           when /in_current_series/
                             CurrentSeries.new(entry_object.race)
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

class AggregationRange
  def initialize(race)
    @race = race
  end

  def value
    aggregate_starts_at...aggregate_ends_at
  end

  private

  attr_reader :race

  # 失格は時刻単位で取らないとダメ
  #
  # 例えば以下のレース
  # http://boatrace.jp/owpc/pc/race/racelist?rno=3&jcd=16&hd=20181216
  #
  # 4220 深川 はこのレースでフライングをした
  # このレース開始時点ではまだF1なので, このレース後にF2になるのが正しい
  # しかし、これを日付で取ってしまうとこのレースでのフライングも含まれてしまい、レース開始前にF2だと判定されてしまう
  #
  # したがって、レースの発売締め切り時刻を基準にdatetimeの粒度で選択しないと意図しない失格判定がされてしまい、
  # 予想に支障をきたすため締め切り時刻を基準とすること
  def aggregate_ends_at
    @aggregate_ends_at ||= race.betting_deadline_at
  end
end

class CurrentTerm < AggregationRange
  private

  def offset_date
    @offset_date ||= race.date
  end

  def current_term
    @current_term ||= RacerRatingEvaluationTerm.initialize_by(date: offset_date)
  end

  def aggregate_starts_at
    @aggregate_starts_at ||= current_term.starts_on.to_datetime.in_time_zone
  end
end

class CurrentSeries < AggregationRange
  private

  def event
    raise DataNotPrepared if race.event.blank?

    race.event
  end

  def aggregate_starts_at
    @aggregate_starts_at ||= event.starts_on.to_datetime
  end
end
