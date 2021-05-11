class RaceExhibitionRecordListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :pit_number,
    :racer_registration_number,
    :exhibition_time,
    :start_course,
    :start_time,
    :is_flying,
    :is_lateness,
    :exhibition_time_order,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      is_lateness = ActiveRecord::Type::Boolean.new.cast(row[9])
      if is_lateness
        signed_start_time = StartExhibitionRecord::LATENESS_START_TIME
      else
        is_flying = ActiveRecord::Type::Boolean.new.cast(row[8])
        start_time = row[7].to_f
        signed_start_time = is_flying ? -start_time : start_time
      end

      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        pit_number: row[3].to_i,
        course_number: row[6].to_i,
        start_time: signed_start_time,
        exhibition_time: row[5].to_f,
        exhibition_time_order: row[10].to_i,
      }
    end
  end
end
