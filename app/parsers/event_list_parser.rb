class EventListParser < BaseParser
  HEADER_KEYS = [:stadium_tel_code, :title, :starts_on, :days, :grade, :kind]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        stadium_tel_code: row[0],
        title: row[1],
        starts_on: row[2].to_date,
        grade: row[4],
        kind: row[5],
      }
    end
  end
end
