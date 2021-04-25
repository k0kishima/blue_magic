class RaceRecordListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :pit_number,
    :time_minute,
    :time_second,
    :start_course,
    :start_time,
    :winning_trick_name,
    :arrival,
    :disqualification_mark,
    :start_order,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      disqualification_mark = row[10]
      disqualification = if disqualification_mark.present?
                           DisqualificationFactory.create!(disqualification_mark)
                         else
                           nil
                         end

      start_time = row[7]
      signed_start_time = if start_time.present?
                            (disqualification == :flying ? -start_time : start_time).to_f
                          else
                            nil
                          end

      time_minute_str = row[4]
      time_second_str = row[5]
      race_time = if time_minute_str.present?
                    (time_minute_str.to_i * 60) + time_second_str.to_i
                  else
                    nil
                  end

      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        pit_number: row[3].to_i,
        course_number: row[6] && row[6].to_i,
        start_time: signed_start_time,
        start_order: row[11] && row[11].to_i,
        race_time: race_time,
        arrival: row[9] && row[9].to_i,
      }
    end.reject { |hash| hash[:course_number].blank? }
  end
end
