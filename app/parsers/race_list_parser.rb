class RaceListParser < BaseParser
  HEADER_KEYS = [:date,
                 :stadium_tel_code,
                 :number,
                 :is_course_fixed,
                 :use_stabilizer,
                 :deadline,
                 :title,
                 :metre,]

  # hack: モデルに持つべきかもしれないが他に再利用する箇所が今のところないので一旦ここで
  METRE_PER_LAP = 600

  def parse!
    validate_header_keys!

    rows.map do |row|
      date = row[0].to_date
      hour, min = row[5].split(':').map(&:to_i)
      betting_deadline_at = date.to_datetime.in_time_zone.change(hour: hour, min: min)

      {
        date: date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        course_fixed: ActiveRecord::Type::Boolean.new.cast(row[3]),
        use_stabilizer: ActiveRecord::Type::Boolean.new.cast(row[4]),
        betting_deadline_at: betting_deadline_at,
        title: row[6],
        number_of_laps: row[7].to_i / METRE_PER_LAP,
      }
    end
  end
end
