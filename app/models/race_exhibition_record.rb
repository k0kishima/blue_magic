class RaceExhibitionRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :start_time, presence: true
  validates :exhibition_time, presence: true
  validates :exhibition_time_order, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
end

# == Schema Information
#
# Table name: race_exhibition_records
#
#  course_number         :integer          not null
#  date                  :date             not null, primary key
#  exhibition_time       :float(24)        not null
#  exhibition_time_order :integer          not null
#  pit_number            :integer          not null, primary key
#  race_number           :integer          not null, primary key
#  stadium_tel_code      :integer          not null, primary key
#  start_time            :float(24)        not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
