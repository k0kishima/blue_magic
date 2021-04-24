class BoatBettingContributeRateAggregationParser < BaseParser
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
  ]

  def parse!
    validate_header_keys!

    rows.map do |row|
      {
        stadium_tel_code: row[1].to_i,
        boat_number: row[11].to_i,
        aggregated_on: row[0].to_date,
        quinella_rate: row[12].to_f,
        trio_rate: row[13].to_f,
      }
    end
  end
end
