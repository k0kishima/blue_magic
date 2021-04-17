class BoatBettingContributeRateAggregation < ApplicationRecord
  include StadiumAssociating

  self.primary_keys = [:stadium_tel_code, :boat_number, :aggregated_on]

  # NOTE: 三連対率に関しては2015年当たりだと公式サイトにデータとして記載がない場合があったのでNULLを許可
  validates :boat_number, presence: true, numericality: { only_integer: true }, length: { in: 1..999 }
  validates :aggregated_on, presence: true
  validates :quinella_rate, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 100.0
  }
  validates :trio_rate, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 100.0
  }
end
