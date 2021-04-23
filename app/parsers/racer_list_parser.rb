class RacerListParser < BaseParser
  HEADER_KEYS = [:last_name,
                 :first_name,
                 :registration_number,
                 :birth_date,
                 :height,
                 :weight,
                 :branch_prefecture,
                 :born_prefecture,
                 :term,
                 :current_rating,]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        last_name: row[0],
        first_name: row[1],
        registration_number: row[2].to_i,
        term: row[8].to_i,
        birth_date: row[3].to_date,
        branch_id: Prefecture.find(name: row[6])&.code,
        birth_prefecture_id: Prefecture.find(name: row[7])&.code,
        height: row[4].to_f,
      }
    end
  end
end
