require 'rails_helper'

describe MotorBettingContributeRateAggregation, type: :model do
  let(:motor_betting_contribute_rate_aggregation) { create(:motor_betting_contribute_rate_aggregation) }

  describe 'association' do
    subject { motor_betting_contribute_rate_aggregation }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { motor_betting_contribute_rate_aggregation }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:motor_number) }
    it {
      is_expected.to validate_numericality_of(:motor_number)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(999)
    }
    it { is_expected.to validate_presence_of(:aggregated_on) }
    it { is_expected.to validate_presence_of(:quinella_rate) }
    it {
      is_expected.to validate_numericality_of(:quinella_rate)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than_or_equal_to(100.0)
    }
    it {
      is_expected.to validate_numericality_of(:trio_rate)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than_or_equal_to(100.0)
    }
  end
end

# == Schema Information
#
# Table name: motor_betting_contribute_rate_aggregations
#
#  stadium_tel_code :integer          not null, primary key
#  motor_number     :integer          not null, primary key
#  aggregated_on    :date             not null, primary key
#  quinella_rate    :float(24)        not null
#  trio_rate        :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
