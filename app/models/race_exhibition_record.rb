class RaceExhibitionRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :start_time, presence: true
  validates :exhibition_time, presence: true
  validates :exhibition_time_order, presence: true
end
