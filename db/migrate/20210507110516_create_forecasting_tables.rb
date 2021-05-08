class CreateForecastingTables < ActiveRecord::Migration[6.1]
  def change
    create_table :forecasters, bulk: true do |t|
      t.integer :status, null: false
      t.string :name, null: false
      t.text :description
      t.integer :reduce_odds_method, null: false

      t.timestamps
    end

    create_table :forecasting_patterns, bulk: true do |t|
      t.string :name, null: false
      t.text :description
      t.json :race_filtering_condition, null: false
      t.json :first_place_filtering_condition, null: false
      t.json :second_place_filtering_condition, null: false
      t.json :third_place_filtering_condition, null: false
      t.json :odds_filtering_condition, null: false
      t.datetime :frozen_at

      t.timestamps
    end

    create_table :forecasters_forecasting_patterns, bulk: true do |t|
      t.references :forecaster, foreign_key: true, index: { name: :foreign_key_1 }
      t.references :forecasting_pattern, foreign_key: true, index: { name: :foreign_key_2 }
      t.integer :budget_amount_per_race, null: false
      t.integer :fund_allocation_method, null: false
      t.float :composition_odds, null: false

      t.timestamps
    end
    add_index :forecasters_forecasting_patterns, %i[forecaster_id forecasting_pattern_id], unique: true, name: :uniq_index_1

    create_table :bettings,
                 primary_key: %i[forecasters_forecasting_pattern_id stadium_tel_code date race_number betting_number], bulk: true do |t|
      t.references :forecasters_forecasting_pattern, foreign_key: true, index: { name: :foreign_key_1 }
      t.integer :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :betting_method, null: false
      t.integer :betting_number, null: false
      t.float :ratio_when_bet, null: false
      t.integer :betting_amount, null: false
      t.integer :refunded_amount, null: true
      t.integer :adjustment_amount, null: true
      t.datetime :bet_at, null: false

      t.timestamps
    end
  end
end
