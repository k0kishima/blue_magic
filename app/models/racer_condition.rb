class RacerCondition < ApplicationRecord
  self.primary_keys = [:date, :racer_registration_number]

  belongs_to :racer, foreign_key: :racer_registration_number, optional: true

  validates :date, presence: true
  validates :racer_registration_number, presence: true
  validates :weight, presence: true
  validates :adjust, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 10.0
  }
end

# == Schema Information
#
# Table name: racer_conditions
#
#  racer_registration_number :integer          not null, primary key
#  date                      :date             not null, primary key
#  weight                    :float(24)        not null
#  adjust                    :float(24)        not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
