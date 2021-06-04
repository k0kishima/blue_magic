class FixForecasterTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :forecasters, :reduce_odds_method, :integer
    add_column :forecasters, :betting_strategy, :integer, null: false, after: :description
  end
end
