class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :racers, primary_key: :registration_number, id: :integer do |t|
      t.string  :last_name, null: false, default: ''
      t.string  :first_name, null: false, default: ''
      t.integer :gender
      t.integer :term
      t.date    :birth_date
      t.integer :branch_id
      t.integer :birth_prefecture_id
      t.integer :height
      t.integer :status

      t.timestamps
    end

    create_table :stadiums, primary_key: :tel_code, id: :integer do |t|
      t.string :name, null: false
      t.integer :prefecture_id, null: false
      t.integer :water_quality, null: false
      t.boolean :tide_fluctuation, null: false
      t.float :lat, null: false
      t.float :lng, null: false
      t.float :elevation, null: false

      t.timestamps
    end

    create_table :events, primary_key: [:stadium_tel_code, :starts_on, :title] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :starts_on, null: false
      t.string :title, null: false
      t.integer :grade, null: false
      t.integer :kind, null: false
      t.boolean :canceled, null: false, default: false

      t.timestamps
    end
    add_foreign_key :events, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :races, primary_key: [:stadium_tel_code, :date, :race_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.string :title, null: false
      t.boolean :course_fixed, null: false, default: false
      t.boolean :use_stabilizer, null: false, default: false
      t.integer :number_of_laps, null: false, default: 3
      t.datetime :betting_deadline_at, null: false
      t.boolean :canceled, null: false, default: false

      t.timestamps
    end
    add_foreign_key :races, :stadiums, column: :stadium_tel_code, primary_key: :tel_code
    add_index :races, :betting_deadline_at

    create_table :race_entries, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :racer_registration_number, null: false
      t.integer :pit_number, null: false

      t.timestamps
    end
    add_foreign_key :race_entries, :stadiums, column: :stadium_tel_code, primary_key: :tel_code
    add_index :race_entries, [:stadium_tel_code, :date, :race_number, :racer_registration_number], unique: true, name: :uniq_index_1

    create_table :racer_conditions, primary_key: [:racer_registration_number, :date] do |t|
      t.integer :racer_registration_number, null: false
      t.date :date, null: false
      t.float :weight, null: false
      t.float :adjust, null: false

      t.timestamps
    end

    create_table :weather_conditions, primary_key: [:stadium_tel_code, :date, :race_number, :in_performance] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.boolean :in_performance, null: false
      t.integer :weather, null: false
      t.float :wind_velocity, null: false
      t.float :wind_angle
      t.float :wavelength
      t.float :air_temperature, null: false
      t.float :water_temperature, null: false

      t.timestamps
    end
    add_foreign_key :weather_conditions, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :start_exhibition_records, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.integer :course_number, null: false
      t.float :start_time, null: false

      t.timestamps
    end
    add_foreign_key :start_exhibition_records, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :circumference_exhibition_records, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.float :exhibition_time, null: false
      t.integer :exhibition_time_order, null: false

      t.timestamps
    end
    add_foreign_key :circumference_exhibition_records, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :race_records, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.integer :course_number, null: false
      t.float :start_time
      t.integer :start_order
      t.float :race_time
      t.integer :arrival

      t.timestamps
    end
    add_foreign_key :race_records, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :winning_race_entries, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.integer :winning_trick, null: false

      t.timestamps
    end
    add_foreign_key :winning_race_entries, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :disqualified_race_entries, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.integer :disqualification, null: false

      t.timestamps
    end
    add_foreign_key :disqualified_race_entries, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :boat_settings, primary_key: [:stadium_tel_code, :date, :race_number, :pit_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :pit_number, null: false
      t.integer :boat_number, null: false
      t.integer :motor_number, null: false
      t.float :tilt, null: false
      t.boolean :propeller_renewed, null: false

      t.timestamps
    end
    add_foreign_key :boat_settings, :stadiums, column: :stadium_tel_code, primary_key: :tel_code
    add_index :boat_settings, [:stadium_tel_code, :date, :race_number, :boat_number], unique: true, name: :uniq_index_1
    add_index :boat_settings, [:stadium_tel_code, :date, :race_number, :motor_number], unique: true, name: :uniq_index_2

    create_table :motor_maintenances, primary_key: [:stadium_tel_code, :date, :race_number, :motor_number, :exchanged_parts] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :motor_number, null: false
      t.integer :exchanged_parts, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
    add_foreign_key :motor_maintenances, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :motor_renewals, primary_key: [:stadium_tel_code, :date] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false

      t.timestamps
    end
    add_foreign_key :motor_renewals, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :payoffs, primary_key: [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :betting_method, null: false
      t.integer :betting_number, null: false
      t.integer :amount, null: false

      t.timestamps
    end
    add_foreign_key :payoffs, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :odds, primary_key: [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :betting_method, null: false
      t.integer :betting_number, null: false
      t.float :ratio, null: false

      t.timestamps
    end
    add_foreign_key :odds, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :racer_winning_rate_aggregations, primary_key: [:racer_registration_number, :aggregated_on] do |t|
      t.integer :racer_registration_number, null: false
      t.date :aggregated_on, null: false
      t.float :rate_in_all_stadium, null: false
      t.float :rate_in_event_going_stadium, null: false

      t.timestamps
    end

    create_table :motor_betting_contribute_rate_aggregations, primary_key: [:stadium_tel_code, :motor_number, :aggregated_on] do |t|
      t.integer :stadium_tel_code, null: false
      t.integer :motor_number, null: false
      t.date :aggregated_on, null: false
      t.float :quinella_rate, null: false
      t.float :trio_rate

      t.timestamps
    end
    add_foreign_key :motor_betting_contribute_rate_aggregations, :stadiums, column: :stadium_tel_code, primary_key: :tel_code

    create_table :boat_betting_contribute_rate_aggregations, primary_key: [:stadium_tel_code, :boat_number, :aggregated_on] do |t|
      t.integer :stadium_tel_code, null: false
      t.integer :boat_number, null: false
      t.date :aggregated_on, null: false
      t.float :quinella_rate, null: false
      t.float :trio_rate

      t.timestamps
    end
    add_foreign_key :boat_betting_contribute_rate_aggregations, :stadiums, column: :stadium_tel_code, primary_key: :tel_code
  end
end
