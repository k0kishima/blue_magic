class RacerWinningRateAggregation < ApplicationRecord
  self.primary_keys = [:racer_registration_number, :aggregated_on]

  validates :racer_registration_number, presence: true
  validates :aggregated_on, presence: true
  validates :rate_in_all_stadium, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 10.0
  }
  # 当地勝率は稀に10を超えることがある
  # 集計期間中に当地の重賞1回だけ斡旋されててそれでパーフェクトVとか準パーフェクト達成したらなり得る
  # 例)
  # http://boatrace.jp/owpc/pc/race/racelist?rno=12&jcd=04&hd=20170511
  validates :rate_in_event_going_stadium, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 12.0
  }
end

# == Schema Information
#
# Table name: racer_winning_rate_aggregations
#
#  racer_registration_number   :integer          not null, primary key
#  aggregated_on               :date             not null, primary key
#  rate_in_all_stadium         :float(24)        not null
#  rate_in_event_going_stadium :float(24)        not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
