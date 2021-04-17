class RacerCondition < ApplicationRecord
  self.primary_keys = [:date, :racer_registration_number]

  belongs_to :racer, foreign_key: :racer_registration_number

  validates :date, presence: true
  validates :racer_registration_number, presence: true
  validates :weight, presence: true
  validates :adjust, presence: true
end

# == Schema Information
#
# Table name: racer_conditions
#
#  adjust                    :float(24)        not null
#  date                      :date             not null, primary key
#  racer_registration_number :integer          not null, primary key
#  weight                    :float(24)        not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (racer_registration_number => racers.registration_number)
#
