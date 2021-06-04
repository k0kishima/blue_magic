class CreateKpis < ActiveRecord::Migration[6.1]
  def change
    create_table :kpis do |t|
      t.string :type, null: false
      t.string :entry_object_class_name, null: false, comment: '値の算出をするために利用するオブジェクトのことをentry object と定義し、そのクラス名をここで指定（webpackのエントリーポイントとのアナロジーからこのように命名）'
      t.string :name, null: false
      t.text :description, null: true
      t.string :attribute_name, null: false

      t.timestamps
    end
    add_index :kpis, :attribute_name, unique: true
  end
end
