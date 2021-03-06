class WinningRaceEntryListParser < BaseParser
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
      winning_trick_name = row[8]
      next if winning_trick_name.blank?

      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        pit_number: row[3].to_i,
        winning_trick: WinningTrickFactory.create!(winning_trick_name),
      }
    end.reject(&:blank?)
  end
end
