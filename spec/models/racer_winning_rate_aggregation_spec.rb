require 'rails_helper'

describe RacerWinningRateAggregation, type: :model do
  let(:racer_winning_rate_aggregation) { create(:racer_winning_rate_aggregation) }

  describe 'validations' do
    subject { racer_winning_rate_aggregation }

    it { is_expected.to validate_presence_of(:racer_registration_number) }
    it { is_expected.to validate_presence_of(:rate_in_all_stadium) }
    it {
      is_expected.to validate_numericality_of(:rate_in_all_stadium)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than_or_equal_to(10.0)
    }
    it { is_expected.to validate_presence_of(:rate_in_event_going_stadium) }
    it {
      is_expected.to validate_numericality_of(:rate_in_event_going_stadium)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than_or_equal_to(12.0)
    }
    it { is_expected.to validate_presence_of(:aggregated_on) }
  end
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
