class Forecaster < ApplicationRecord
  has_many :forecasting_suites_forecasting_types

  enum status: { active: 1, simulating: 2 }

  validates :name, presence: true
  validates :status, presence: true
  validates :reduce_odds_method, presence: true, inclusion: { in: ReduceOddsMethod.all }

  def self.current
    raise NotImplementedError
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id                 :bigint           not null, primary key
#  status             :integer          not null
#  name               :string(255)      not null
#  description        :text(65535)
#  reduce_odds_method :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
