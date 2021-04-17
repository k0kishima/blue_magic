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

# == Schema Information
#
# Table name: boat_betting_contribute_rate_aggregations
#
#  aggregated_on    :date             not null, primary key
#  boat_number      :integer          not null, primary key
#  quinella_rate    :float(24)        not null
#  stadium_tel_code :integer          not null, primary key
#  trio_rate        :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
