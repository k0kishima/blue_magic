class BoatSetting < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :boat_number, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 999
  }
  validates :motor_number, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 999
  }
  validates :tilt, presence: true,
                   numericality: { only_float: true, greater_than_or_equal_to: -0.5, less_than_or_equal_to: 3.0 }
  validates :propeller_renewed, inclusion: { in: [true, false] }
end

# == Schema Information
#
# Table name: boat_settings
#
#  boat_number       :integer          not null
#  date              :date             not null, primary key
#  motor_number      :integer          not null
#  pit_number        :integer          not null, primary key
#  propeller_renewed :boolean          not null
#  race_number       :integer          not null, primary key
#  stadium_tel_code  :integer          not null, primary key
#  tilt              :float(24)        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,boat_number) UNIQUE
#  uniq_index_2  (stadium_tel_code,date,race_number,motor_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
