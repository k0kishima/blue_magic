class Event < ApplicationRecord
  include StadiumAssociating

  # FIXME: title を主キーはバグの温床
  #
  # タイトルが一文字でも違っていたら（例えば公式サイトのクロールを何回かかけたときにタイトルが更新されていたら）データが重複して冪等性が担保できなくなる
  # かといってGPやCCみたいなダブル開催は [:stadium_tel_code, :starts_on] だけだと保持できないからすぐには解決策が浮かばない
  self.primary_keys = [:stadium_tel_code, :starts_on, :title]

  enum status: { on_going: 1, done: 2, canceled: 3, }
  enum kind: { uncategorized: 1, all_ladies: 2, venus: 3, rookie: 4, senior: 5, double_winner: 6, tournament: 7, }
  enum grade: { sg: 1, g1: 2, g2: 3, g3: 4, no_grade: 5, }

  validates :starts_on, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :grade, presence: true
  validates :kind, presence: true
end
