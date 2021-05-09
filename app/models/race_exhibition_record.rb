class RaceExhibitionRecord < ApplicationRecord
  include RaceAssociating

  # NOTE:
  # 展示で出遅れが発生した場合、出遅れた艇のSTは固定値で持つ
  # コースも大外とする
  #
  # 理由:
  # * これが数ヶ月に1回しか発生しないレベルのコーナーケースなのにこういう状況のためにNOT NULL制約を外したくない
  # * テーブルも start_exhibitions と circumference_exhibitions に分けるとかしたくない
  #
  # 例)
  # http://boatrace.jp/owpc/pc/race/beforeinfo?rno=2&jcd=17&hd=20170511
  LATENESS_START_TIME = 1.01

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :course_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :start_time, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: -1.0,
    less_than_or_equal_to: LATENESS_START_TIME
  }
  validates :exhibition_time, presence: true
  validates :exhibition_time_order, presence: true, inclusion: { in: Pit::NUMBER_RANGE }

  def lateness?
    start_time == LATENESS_START_TIME
  end
end

# == Schema Information
#
# Table name: race_exhibition_records
#
#  stadium_tel_code      :integer          not null, primary key
#  date                  :date             not null, primary key
#  race_number           :integer          not null, primary key
#  pit_number            :integer          not null, primary key
#  course_number         :integer          not null
#  start_time            :float(24)        not null
#  exhibition_time       :float(24)        not null
#  exhibition_time_order :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
