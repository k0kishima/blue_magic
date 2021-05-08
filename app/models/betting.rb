class Betting < ApplicationRecord
  include RaceAssociating
  include BettingMethodSelector

  self.primary_keys = %i[forecasters_forecasting_pattern_id stadium_tel_code date race_number]

  belongs_to :forecasters_forecasting_pattern

  validates :ratio_when_bet, presence: true
  validates :betting_amount, presence: true
  validates :bet_at, presence: true

  def betting_numbers
    betting_number.to_s.split('').map(&:to_i)
  end
end

# == Schema Information
#
# Table name: bettings
#
#  forecasters_forecasting_pattern_id :bigint           not null, primary key
#  stadium_tel_code                   :integer          not null, primary key
#  date                               :date             not null, primary key
#  race_number                        :integer          not null, primary key
#  betting_method                     :integer          not null
#  betting_number                     :integer          not null
#  ratio_when_bet                     :float(24)        not null
#  betting_amount                     :integer          not null
#  refunded_amount                    :integer
#  adjustment_amount                  :integer
#  bet_at                             :datetime         not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
# Indexes
#
#  foreign_key_1  (forecasters_forecasting_pattern_id)
#
# Foreign Keys
#
#  fk_rails_...  (forecasters_forecasting_pattern_id => forecasters_forecasting_patterns.id)
#
