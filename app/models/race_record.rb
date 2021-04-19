class RaceRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  belongs_to :race_entry, foreign_key: self.primary_keys, optional: true
  has_one :winning_race_entry, foreign_key: self.primary_keys

  # TODO: start_timeのバリデーション入れる
  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :start_order, inclusion: { in: Pit::NUMBER_RANGE }
  validates :arrival, inclusion: { in: Pit::NUMBER_RANGE }
end

# == Schema Information
#
# Table name: race_records
#
#  arrival          :integer
#  course_number    :integer          not null
#  date             :date             not null, primary key
#  pit_number       :integer          not null, primary key
#  race_number      :integer          not null, primary key
#  race_time        :float(24)
#  stadium_tel_code :integer          not null, primary key
#  start_order      :integer
#  start_time       :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
