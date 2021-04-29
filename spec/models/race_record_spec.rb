require 'rails_helper'

describe RaceRecord, type: :model do
  let(:race_record) { create(:race_record) }

  describe 'association' do
    subject { race_record }

    it { is_expected.to belong_to(:stadium) }
    it { is_expected.to belong_to(:race_entry).optional }
    it { is_expected.to have_one(:winning_race_entry).optional }
  end

  describe 'validations' do
    subject { race_record }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:course_number) }
    it { is_expected.to validate_inclusion_of(:course_number).in_range(1..6) }
    it {
      is_expected.to validate_numericality_of(:start_time)
        .is_greater_than_or_equal_to(0.0)
        .is_less_than(1.0)
    }
    it { is_expected.to allow_value(nil).for(:start_time) }
    it { is_expected.to validate_inclusion_of(:start_order).in_range(1..6) }
    it { is_expected.to validate_inclusion_of(:arrival).in_range(1..6) }
  end
end

# == Schema Information
#
# Table name: race_records
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  course_number    :integer          not null
#  start_time       :float(24)
#  start_order      :integer
#  race_time        :float(24)
#  arrival          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
