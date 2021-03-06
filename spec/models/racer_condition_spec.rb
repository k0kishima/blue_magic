require 'rails_helper'

RSpec.describe RacerCondition, type: :model do
  let(:racer_condition) { create(:racer_condition) }

  describe 'association' do
    subject { racer_condition }

    it { is_expected.to belong_to(:racer).optional }
  end

  describe 'validation' do
    subject { racer_condition }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:racer_registration_number) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_presence_of(:adjust) }
    it {
      is_expected.to validate_numericality_of(:adjust)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than_or_equal_to(10.0)
    }
  end
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
