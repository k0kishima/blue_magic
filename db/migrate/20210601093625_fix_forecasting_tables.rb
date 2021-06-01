class FixForecastingTables < ActiveRecord::Migration[6.1]
  def change
    remove_column :bettings, :ratio_when_bet, :float, null: false
    remove_column :bettings, :bet_at, :datetime, null: false
    add_column :bettings, :dry_run, :boolean, null: false, after: :adjustment_amount
    add_column :bettings, :voted_at, :datetime, null: false, after: :dry_run

    create_table :recommend_odds,
                 primary_key: %i[forecasters_forecasting_pattern_id stadium_tel_code date race_number betting_number], bulk: true do |t|
      t.references :forecasters_forecasting_pattern, foreign_key: true, index: { name: :foreign_key_1 }
      t.integer :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.integer :betting_method, null: false
      t.integer :betting_number, null: false
      t.float :ratio_when_forecasting, null: false
      t.integer :should_purchase_quantity, null: false

      t.timestamps
    end
  end
end
