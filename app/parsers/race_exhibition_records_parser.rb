class RaceExhibitionRecordsParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :pit_number,
    :racer_registration_number,
    :exhibition_time,
    :exhibition_time_order,
    :start_course,
    :start_time,
    :is_flying,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      is_flying = ActiveRecord::Type::Boolean.new.cast(row[9])
      start_time = row[8].to_f
      signed_start_time = is_flying ? -start_time : start_time

      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        pit_number: row[3].to_i,
        course_number: row[7].to_i,
        start_time: signed_start_time,
        exhibition_time: row[5].to_f,
        exhibition_time_order: row[6].to_i,
      }
    end
  end
end
