# NOTE:
#
# Odds モデルと構造が似通っているので統一できると設計初期段階では考えていた
# （このテーブルで持ちたいのは払戻し金額だから、odds に当選カラムみたいなの作るか正規化するならhas_one関連でテーブル先にひとつ作るかすればいいと考えていた）
# ただし、ドメインロジック上払戻金は必ずしもオッズの比率と一致するとは言えないため、このようなテーブルで別途保持する必要があると考えた
# 例えば、艇番123、三連単オッズ10倍 で決まったレースでも4号艇がフライングしてたら返還が発生するので、購入時のオッズである10倍（¥1,000）の払戻しではなくなる
class Payoff < ApplicationRecord
  include RaceAssociating
  include Betting

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :betting_method, :betting_number]

  validates :amount, presence: true
end
