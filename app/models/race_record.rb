class RaceRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  belongs_to :race_entry, foreign_key: self.primary_keys, optional: true
  has_one :winning_race_entry, foreign_key: self.primary_keys

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true,
                            inclusion: { in: Pit::NUMBER_RANGE },
                            uniqueness: { scope: [:stadium_tel_code, :date, :race_number] }
  # NOTE: 大時計0からの絶対値で保持しているので符号は考慮しない（本来Fのときは-になるが別途保持している失格データから導出する)
  validates :start_time, numericality: { only_float: true, greater_than_or_equal_to: 0.0, less_than: 1.0 },
                         allow_nil: true
  validates :start_order, inclusion: { in: Pit::NUMBER_RANGE }, allow_nil: true
  validates :arrival, inclusion: { in: Pit::NUMBER_RANGE }, allow_nil: true
end

# == Schema Information
#
# Table name: race_records
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  course_number    :integer          not null
#  start_time       :float(24)
#  start_order      :integer
#  race_time        :float(24)
#  arrival          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
