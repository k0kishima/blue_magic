# NOTE:
# もともとスタート展示と一体となった `RaceExhibitionRecord` で管理していた
# それだと以下のようなスタ展だけ不参加で周回展示だけ出ているケースでSTや進入コースをNULLにしなければならなかったのでモデルを分けた
# http://boatrace.jp/owpc/pc/race/beforeinfo?rno=10&jcd=06&hd=20170625
class CircumferenceExhibitionRecord < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  validates :pit_number,
            presence: true,
            inclusion: { in: Pit::NUMBER_RANGE }
  validates :exhibition_time, presence: true
  validates :exhibition_time_order, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
end

# == Schema Information
#
# Table name: circumference_exhibition_records
#
#  stadium_tel_code      :integer          not null, primary key
#  date                  :date             not null, primary key
#  race_number           :integer          not null, primary key
#  pit_number            :integer          not null, primary key
#  exhibition_time       :float(24)        not null
#  exhibition_time_order :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
