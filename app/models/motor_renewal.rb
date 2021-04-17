class MotorRenewal < ApplicationRecord
  include StadiumAssociating

  self.primary_keys = [:stadium_tel_code, :date]

  validates :date, presence: true
end
