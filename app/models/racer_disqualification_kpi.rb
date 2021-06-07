class RacerDisqualificationKpi < Kpi
  def value!
    validate!(:calculation)

    disqualification_race_entries = DisqualifiedRaceEntry
                                    .joins(race_entry: :race)
                                    .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
                                    .merge(Race.where(betting_deadline_at: aggregate_starts_at...aggregate_ends_at))

    if disqualification.present?
      disqualification_race_entries = disqualification_race_entries.where(disqualification: disqualification)
    end

    disqualification_race_entries.count
  end

  private

  def racer_registration_number
    @racer_registration_number ||= entry_object.racer_registration_number
  end

  def offset_date
    @offset_date ||= entry_object.race.date
  end

  def current_term
    @current_term ||= RacerRatingEvaluationTerm.initialize_by(date: offset_date)
  end

  def aggregate_starts_at
    @aggregate_starts_at ||= current_term.starts_on.to_datetime
  end

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
    @aggregate_ends_at ||= entry_object.race.betting_deadline_at
  end

  def disqualification
    @trick ||= case attribute_name
               when /disqualification_total/
                 nil
               when /flying/
                 Disqualification::ID::FLYING
               when /lateness/
                 Disqualification::ID::LATENESS
               else
                 raise StandardError, "cannot assign a disqualification to key: #{attribute_name}"
               end
  end
end
