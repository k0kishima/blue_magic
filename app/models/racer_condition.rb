class RacerCondition < ApplicationRecord
  self.primary_keys = [:date, :racer_registration_number]

  belongs_to :racer, foreign_key: :racer_registration_number

  validates :date, presence: true
  validates :racer_registration_number, presence: true
  validates :weight, presence: true
  validates :adjust, presence: true
end
