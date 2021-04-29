class CreateImportDataQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :import_data_queues do |t|
      t.integer :status, null: false, default: 0
      t.json :file_data, null: false
      t.text :error_messages

      t.timestamps
    end
  end
end
