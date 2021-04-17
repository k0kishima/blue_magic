class RacerWinningRateAggregation < ApplicationRecord
  self.primary_keys = [:racer_registration_number, :aggregated_on]

  validates :racer_registration_number, presence: true
  validates :aggregated_on, presence: true
  validates :rate_in_all_stadium, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 100.0
  }
  validates :rate_in_event_going_stadium, presence: true, numericality: {
    only_float: true,
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 100.0
  }
end
