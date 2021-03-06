require 'rails_helper'

describe StartExhibitionRecord, type: :model do
  let(:start_exhibition_record) { create(:start_exhibition_record) }

  describe 'association' do
    subject { start_exhibition_record }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { start_exhibition_record }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:course_number) }
    it { is_expected.to validate_inclusion_of(:course_number).in_range(1..6) }
    it { is_expected.to validate_uniqueness_of(:course_number).scoped_to(:stadium_tel_code, :date, :race_number) }
    it { is_expected.to validate_presence_of(:start_time) }
    it {
      is_expected.to validate_numericality_of(:start_time)
        .is_greater_than_or_equal_to(-1.0)
        .is_less_than_or_equal_to(1.01)
    }
  end
end

# == Schema Information
#
# Table name: start_exhibition_records
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  course_number    :integer          not null
#  start_time       :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
