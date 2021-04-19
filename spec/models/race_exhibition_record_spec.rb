require 'rails_helper'

describe RaceExhibitionRecord, type: :model do
  let(:race_exhibition_record) { create(:race_exhibition_record) }

  describe 'association' do
    subject { race_exhibition_record }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { race_exhibition_record }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:course_number) }
    it { is_expected.to validate_inclusion_of(:course_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:exhibition_time) }
    it { is_expected.to validate_presence_of(:exhibition_time_order) }
    it { is_expected.to validate_inclusion_of(:exhibition_time_order).in_range(1..6) }
  end
end

# == Schema Information
#
# Table name: race_exhibition_records
#
#  course_number         :integer          not null
#  date                  :date             not null, primary key
#  exhibition_time       :float(24)        not null
#  exhibition_time_order :integer          not null
#  pit_number            :integer          not null, primary key
#  race_number           :integer          not null, primary key
#  stadium_tel_code      :integer          not null, primary key
#  start_time            :float(24)        not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
