class RaceRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  belongs_to :race_entry, foreign_key: self.primary_keys, optional: true
  has_one :winning_race_entry, foreign_key: self.primary_keys

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
end
