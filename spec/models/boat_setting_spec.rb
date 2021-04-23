require 'rails_helper'

describe BoatBettingContributeRateAggregation, type: :model do
  let(:boat_setting) { create(:boat_setting) }

  describe 'association' do
    subject { boat_setting }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { boat_setting }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:boat_number) }
    it {
      is_expected.to validate_numericality_of(:boat_number)
        .only_integer.is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(999)
    }
    it { is_expected.to validate_presence_of(:motor_number) }
    it {
      is_expected.to validate_numericality_of(:motor_number)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(999)
    }
    it { is_expected.to validate_presence_of(:tilt) }
    it {
      is_expected.to validate_numericality_of(:tilt)
        .is_greater_than_or_equal_to(-0.5)
        .is_less_than_or_equal_to(3.0)
    }
    it { is_expected.to allow_value(true).for(:propeller_renewed) }
    it { is_expected.to allow_value(false).for(:propeller_renewed) }
    it { is_expected.not_to allow_value(nil).for(:propeller_renewed) }
  end
end

# == Schema Information
#
# Table name: boat_settings
#
#  stadium_tel_code  :integer          not null, primary key
#  date              :date             not null, primary key
#  race_number       :integer          not null, primary key
#  pit_number        :integer          not null, primary key
#  boat_number       :integer          not null
#  motor_number      :integer          not null
#  tilt              :float(24)        not null
#  propeller_renewed :boolean          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,boat_number) UNIQUE
#  uniq_index_2  (stadium_tel_code,date,race_number,motor_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
