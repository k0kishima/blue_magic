class Odds < ApplicationRecord
  include RaceAssociating
  include Betting

  self.table_name = :odds
  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  validates :ratio, presence: true
end
