require 'rails_helper'

describe WinningRaceEntry, type: :model do
  let(:winning_race_entry) { create(:winning_race_entry) }

  describe 'association' do
    subject { winning_race_entry }

    it { is_expected.to belong_to(:stadium) }
    it { is_expected.to belong_to(:race_record).optional }
  end

  describe 'validations' do
    subject { winning_race_entry }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:winning_trick) }
  end
end

# == Schema Information
#
# Table name: winning_race_entries
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  winning_trick    :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
