# NOTE:
#
# Odds モデルと構造が似通っているので統一できると設計初期段階では考えていた
# （このテーブルで持ちたいのは払戻し金額だから、odds に当選カラムみたいなの作るか正規化するならhas_one関連でテーブル先にひとつ作るかすればいいと考えていた）
# ただし、ドメインロジック上払戻金は必ずしもオッズの比率と一致するとは言えないため、このようなテーブルで別途保持する必要があると考えた
# 例えば、艇番123、三連単オッズ10倍 で決まったレースでも4号艇がフライングしてたら返還が発生するので、購入時のオッズである10倍（¥1,000）の払戻しではなくなる
class Payoff < ApplicationRecord
  include RaceAssociating
  include BettingMethodSelector

  REFUND_RATE = 0.75

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  validates :amount, presence: true
end

# == Schema Information
#
# Table name: payoffs
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  amount           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
