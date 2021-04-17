class Odds < ApplicationRecord
  include RaceAssociating
  include Betting

  self.table_name = :odds
  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  validates :ratio, presence: true
end

# == Schema Information
#
# Table name: odds
#
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  ratio            :float(24)        not null
#  stadium_tel_code :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
