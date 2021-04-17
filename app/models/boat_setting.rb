class BoatSetting < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :boat_number, presence: true, numericality: { only_integer: true }, length: { in: 1..999 }
  validates :motor_number, presence: true, numericality: { only_integer: true }, length: { in: 1..999 }
  validates :tilt, presence: true,
                   numericality: { only_float: true, greater_than_or_equal_to: -0.5, less_than_or_equal_to: 3.0 }
  validates :propeller_renewed, inclusion: { in: [true, false] }
end
