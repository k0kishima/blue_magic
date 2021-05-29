class Odds < ApplicationRecord
  include RaceAssociating
  include BettingMethodSelector

  self.table_name = :odds
  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true

  validates :ratio, presence: true
end

# == Schema Information
#
# Table name: odds
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  ratio            :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
