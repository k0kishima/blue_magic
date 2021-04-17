class MotorMaintenance < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :motor_number, :exchanged_parts]

  enum exchanged_parts: { electrical_system: 1, carburetor: 2, piston: 3, piston_ring: 4, cylinder: 5, crankshaft: 6,
                          gear_case: 7, carrier_body: 8 }

  # TODO: 1以上 x未満 のチェック入れた方がいいのでは？あとパーツによって替えられる個数が違ってくる（例えば電気系統を2つ取り換えるとかは不可）
  validates :quantity, presence: true
end
