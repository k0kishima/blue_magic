class BoatSetting < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  has_one :motor_betting_contribute_rate_aggregation, foreign_key: [:stadium_tel_code, :aggregated_on, :motor_number],
                                                      primary_key: [:stadium_tel_code, :date, :motor_number]
  has_one :boat_betting_contribute_rate_aggregation, foreign_key: [:stadium_tel_code, :aggregated_on, :boat_number],
                                                      primary_key: [:stadium_tel_code, :date, :boat_number]

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

  def motor_quinella_rate
    motor_betting_contribute_rate_aggregation.quinella_rate
  end

  def motor_trio_rate
    motor_betting_contribute_rate_aggregation.trio_rate
  end

  def boat_quinella_rate
    boat_betting_contribute_rate_aggregation.quinella_rate
  end

  def boat_trio_rate
    boat_betting_contribute_rate_aggregation.trio_rate
  end
end

# == Schema Information
#
# Table name: boat_settings
#
#  stadium_tel_code  :integer          not null, primary key
#  date              :date             not null, primary key
#  race_number       :integer          not null, primary key
#  pit_number        :integer          not null, primary key
#  boat_number       :integer          not null
#  motor_number      :integer          not null
#  tilt              :float(24)        not null
#  propeller_renewed :boolean          not null
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
