require 'rails_helper'

describe DisqualifiedRaceEntry, type: :model do
  let(:disqualified_race_entry) { create(:disqualified_race_entry) }

  describe 'association' do
    subject { disqualified_race_entry }

    it { is_expected.to belong_to(:stadium) }
    it { is_expected.to belong_to(:race_entry).optional }
  end

  describe 'validations' do
    subject { disqualified_race_entry }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:disqualification) }
  end
end

# == Schema Information
#
# Table name: disqualified_race_entries
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  disqualification :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
