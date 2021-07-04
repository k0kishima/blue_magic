class CreateRaceAnalysisCaches < ActiveRecord::Migration[6.1]
  def change
    create_table :race_analysis_caches, primary_key: [:stadium_tel_code, :date, :race_number] do |t|
      t.integer  :stadium_tel_code, null: false
      t.date :date, null: false
      t.integer :race_number, null: false
      t.json :data
      t.text :error_message

      t.timestamps
    end
  end
end
