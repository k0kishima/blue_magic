class Event < ApplicationRecord
  include StadiumAssociating

  # FIXME: title を主キーはバグの温床
  #
  # タイトルが一文字でも違っていたら（例えば公式サイトのクロールを何回かかけたときにタイトルが更新されていたら）データが重複して冪等性が担保できなくなる
  # かといってGPやCCみたいなダブル開催は [:stadium_tel_code, :starts_on] だけだと保持できないからすぐには解決策が浮かばない
  self.primary_keys = [:stadium_tel_code, :starts_on, :title]

  enum kind: { uncategorized: 1, all_ladies: 2, venus: 3, rookie: 4, senior: 5, double_winner: 6, tournament: 7, }
  enum grade: { sg: 1, g1: 2, g2: 3, g3: 4, no_grade: 5, }

  validates :starts_on, presence: true
  validates :title, presence: true
  validates :grade, presence: true
  validates :kind, presence: true
end

# == Schema Information
#
# Table name: events
#
#  stadium_tel_code :integer          not null, primary key
#  starts_on        :date             not null, primary key
#  title            :string(255)      not null, primary key
#  grade            :integer          not null
#  kind             :integer          not null
#  canceled         :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
