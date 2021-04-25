class PayoffListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :betting_method,
    :betting_number,
    :amount,
  ]

  def parse!
    validate_header_keys!
    rows.map do |row|
      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        betting_method: row[3],
        betting_number: row[4].gsub('-', '').to_i,
        amount: row[5].to_i,
      }
    end
  end
end
