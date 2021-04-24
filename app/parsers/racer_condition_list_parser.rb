class RacerConditionListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :pit_number,
    :racer_registration_number,
    :weight,
    :adjust,
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        date: row[0].to_date,
        racer_registration_number: row[2].to_i,
        weight: row[3].to_f,
        adjust: row[4].to_f,
      }
    end
  end
end
