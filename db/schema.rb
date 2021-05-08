# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_07_110516) do

  create_table "bettings", primary_key: ["forecasters_forecasting_pattern_id", "stadium_tel_code", "date", "race_number", "betting_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "forecasters_forecasting_pattern_id", null: false
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "betting_method", null: false
    t.integer "betting_number", null: false
    t.float "ratio_when_bet", null: false
    t.integer "betting_amount", null: false
    t.integer "refunded_amount"
    t.integer "adjustment_amount"
    t.datetime "bet_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["forecasters_forecasting_pattern_id"], name: "foreign_key_1"
  end

  create_table "boat_betting_contribute_rate_aggregations", primary_key: ["stadium_tel_code", "boat_number", "aggregated_on"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.integer "boat_number", null: false
    t.date "aggregated_on", null: false
    t.float "quinella_rate", null: false
    t.float "trio_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "boat_settings", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "pit_number", null: false
    t.integer "boat_number", null: false
    t.integer "motor_number", null: false
    t.float "tilt", null: false
    t.boolean "propeller_renewed", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stadium_tel_code", "date", "race_number", "boat_number"], name: "uniq_index_1", unique: true
    t.index ["stadium_tel_code", "date", "race_number", "motor_number"], name: "uniq_index_2", unique: true
  end

  create_table "disqualified_race_entries", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "pit_number", null: false
    t.integer "disqualification", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", primary_key: ["stadium_tel_code", "starts_on", "title"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "starts_on", null: false
    t.string "title", null: false
    t.integer "grade", null: false
    t.integer "kind", null: false
    t.boolean "canceled", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "forecasters", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "status", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "reduce_odds_method", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "forecasters_forecasting_patterns", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "forecaster_id"
    t.bigint "forecasting_pattern_id"
    t.integer "budget_amount_per_race", null: false
    t.integer "fund_allocation_method", null: false
    t.float "composition_odds", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["forecaster_id", "forecasting_pattern_id"], name: "uniq_index_1", unique: true
    t.index ["forecaster_id"], name: "foreign_key_1"
    t.index ["forecasting_pattern_id"], name: "foreign_key_2"
  end

  create_table "forecasting_patterns", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.json "race_filtering_condition", null: false
    t.json "first_place_filtering_condition", null: false
    t.json "second_place_filtering_condition", null: false
    t.json "third_place_filtering_condition", null: false
    t.json "odds_filtering_condition", null: false
    t.datetime "frozen_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "import_data_queues", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.json "file_data", null: false
    t.text "error_messages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "motor_betting_contribute_rate_aggregations", primary_key: ["stadium_tel_code", "motor_number", "aggregated_on"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.integer "motor_number", null: false
    t.date "aggregated_on", null: false
    t.float "quinella_rate", null: false
    t.float "trio_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "motor_maintenances", primary_key: ["stadium_tel_code", "date", "race_number", "motor_number", "exchanged_parts"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "motor_number", null: false
    t.integer "exchanged_parts", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "motor_renewals", primary_key: ["stadium_tel_code", "date"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "odds", primary_key: ["stadium_tel_code", "date", "race_number", "betting_method", "betting_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "betting_method", null: false
    t.integer "betting_number", null: false
    t.float "ratio", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payoffs", primary_key: ["stadium_tel_code", "date", "race_number", "betting_method", "betting_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "betting_method", null: false
    t.integer "betting_number", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_entries", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "racer_registration_number", null: false
    t.integer "pit_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stadium_tel_code", "date", "race_number", "racer_registration_number"], name: "uniq_index_1", unique: true
  end

  create_table "race_exhibition_records", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "pit_number", null: false
    t.integer "course_number", null: false
    t.float "start_time", null: false
    t.float "exhibition_time", null: false
    t.integer "exhibition_time_order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_records", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "pit_number", null: false
    t.integer "course_number", null: false
    t.float "start_time"
    t.integer "start_order"
    t.float "race_time"
    t.integer "arrival"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "racer_conditions", primary_key: ["racer_registration_number", "date"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "racer_registration_number", null: false
    t.date "date", null: false
    t.float "weight", null: false
    t.float "adjust", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "racer_winning_rate_aggregations", primary_key: ["racer_registration_number", "aggregated_on"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "racer_registration_number", null: false
    t.date "aggregated_on", null: false
    t.float "rate_in_all_stadium", null: false
    t.float "rate_in_event_going_stadium", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "racers", primary_key: "registration_number", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "last_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.integer "gender"
    t.integer "term"
    t.date "birth_date"
    t.integer "branch_id"
    t.integer "birth_prefecture_id"
    t.integer "height"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", primary_key: ["stadium_tel_code", "date", "race_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.string "title", null: false
    t.boolean "course_fixed", default: false, null: false
    t.boolean "use_stabilizer", default: false, null: false
    t.integer "number_of_laps", default: 3, null: false
    t.datetime "betting_deadline_at", null: false
    t.boolean "canceled", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["betting_deadline_at"], name: "index_races_on_betting_deadline_at"
  end

  create_table "settings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "stadiums", primary_key: "tel_code", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "prefecture_id", null: false
    t.integer "water_quality", null: false
    t.boolean "tide_fluctuation", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.float "elevation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weather_conditions", primary_key: ["stadium_tel_code", "date", "race_number", "in_performance"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.boolean "in_performance", null: false
    t.integer "weather", null: false
    t.float "wind_velocity", null: false
    t.float "wind_angle"
    t.float "wavelength"
    t.float "air_temperature", null: false
    t.float "water_temperature", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "winning_race_entries", primary_key: ["stadium_tel_code", "date", "race_number", "pit_number"], charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "stadium_tel_code", null: false
    t.date "date", null: false
    t.integer "race_number", null: false
    t.integer "pit_number", null: false
    t.integer "winning_trick", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bettings", "forecasters_forecasting_patterns"
  add_foreign_key "boat_betting_contribute_rate_aggregations", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "boat_settings", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "disqualified_race_entries", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "events", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "forecasters_forecasting_patterns", "forecasters"
  add_foreign_key "forecasters_forecasting_patterns", "forecasting_patterns"
  add_foreign_key "motor_betting_contribute_rate_aggregations", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "motor_maintenances", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "motor_renewals", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "odds", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "payoffs", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "race_entries", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "race_exhibition_records", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "race_records", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "races", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "weather_conditions", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
  add_foreign_key "winning_race_entries", "stadiums", column: "stadium_tel_code", primary_key: "tel_code"
end
