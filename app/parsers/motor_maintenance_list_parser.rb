class MotorMaintenanceListParser < BaseParser
  HEADER_KEYS = [
    :date,
    :stadium_tel_code,
    :race_number,
    :racer_registration_number,
    :racer_first_name,
    :racer_last_name,
    :racer_rank,
    :pit_number,
    :motor_number,
    :quinella_rate_of_motor,
    :trio_rate_of_motor,
    :boat_number,
    :quinella_rate_of_boat,
    :trio_rate_of_boat,
    :whole_country_winning_rate,
    :local_winning_rate,
    :whole_country_quinella_rate_of_racer,
    :whole_country_trio_rate_of_racer,
    :local_quinella_rate_of_racer,
    :local_trio_rate_of_racer,
    :is_absent,
    :parts_exchanges,
  ]

  def parse!
    validate_header_keys!

    parts_exchanged_rows = rows.reject { |row| row[21].blank? }
    parts_exchanged_rows.map do |row|
      JSON.parse(row[21]).map do |parts_exchange|
        {
          date: row[0].to_date,
          stadium_tel_code: row[1].to_i,
          race_number: row[2].to_i,
          motor_number: row[8].to_i,
          exchanged_parts: MotorPartsFactory.create!(parts_exchange['parts_name']),
          quantity: parts_exchange['count'].to_i
        }
      end
    end.flatten
  end
end
