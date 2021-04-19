class MotorMaintenance < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :motor_number, :exchanged_parts]

  enum exchanged_parts: { electrical_system: 1, carburetor: 2, piston: 3, piston_ring: 4, cylinder: 5, crankshaft: 6,
                          gear_case: 7, carrier_body: 8 }

  validates :date, presence: true
  validates :motor_number, presence: true
  validates :exchanged_parts, presence: true
  # TODO: 1以上 x未満 のチェック入れた方がいいのでは？あとパーツによって替えられる個数が違ってくる（例えば電気系統を2つ取り換えるとかは不可）
  validates :quantity, presence: true
end

# == Schema Information
#
# Table name: motor_maintenances
#
#  date             :date             not null, primary key
#  exchanged_parts  :integer          not null, primary key
#  motor_number     :integer          not null, primary key
#  quantity         :integer          not null
#  race_number      :integer          not null, primary key
#  stadium_tel_code :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
