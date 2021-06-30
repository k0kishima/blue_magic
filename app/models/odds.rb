class Odds < ApplicationRecord
  include RaceAssociating
  include BettingMethodSelector

  self.table_name = :odds
  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  # TODO: 副作用のない方法で動作するように修正する
  # 予想処理時にはいくつかの属性が設定された(デコレートされた) RaceEntry のオブジェクトが必要になる
  # さらにそれらを Race オブジェクト が computed property で算出に利用している
  # したがって、動的に変更された RaceEntry を利用した Raceオブジェクトが必要になるが、
  # 下記のような宣言で取得するオブジェクトでは都度上記調整を行わなければならないため、
  # 今はアクセサ経由でデコレートされたオブジェクトを代入している
  # belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true
  attr_accessor :race

  validates :ratio, presence: true

  def betting_numbers
    betting_number.to_s.split('').map(&:to_i)
  end

  def first
    betting_numbers.first
  end

  def second
    betting_numbers.second
  end

  def third
    betting_numbers.third
  end
end

# == Schema Information
#
# Table name: odds
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  ratio            :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
