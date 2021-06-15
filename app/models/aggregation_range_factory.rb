class AggregationRangeFactory
  module AGGREGATION_YEARS
    RACER = 1
    STADIUM = 99
  end

  class << self
  	def create_to_aggregate_racer_data_from(race_opened_on)
      first = (race_opened_on - AGGREGATION_YEARS::RACER.years).beginning_of_month
      last = race_opened_on.prev_month.end_of_month
      first..last
  	end

  	def create_to_aggregate_stadium_data_from(race_opened_on)
      first = (race_opened_on - AGGREGATION_YEARS::STADIUM.years).beginning_of_month
      last = race_opened_on.prev_month.end_of_month
      first..last
  	end
  end
end
