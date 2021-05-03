class BoatSettingListParser < BaseParser
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
    :tilt,
    :is_new_propeller
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      is_absent = ActiveRecord::Type::Boolean.new.cast(row[20])
      next if is_absent

      {
        date: row[0].to_date,
        stadium_tel_code: row[1].to_i,
        race_number: row[2].to_i,
        pit_number: row[7].to_i,
        boat_number: row[11].to_i,
        motor_number: row[8].to_i,
        tilt: row[21].to_f,
        propeller_renewed: ActiveRecord::Type::Boolean.new.cast(row[22]),
      }
    end.compact
  end
end
