class OddsListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :betting_number,
    :ratio,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        betting_method: :trifecta,  # TODO: 3連単以外に対応する必要が出てきた時点で修正
        betting_number: row[3].to_i,
        ratio: row[4].to_f,
      }
    end
  end
end
