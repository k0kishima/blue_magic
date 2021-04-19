require 'rails_helper'

describe Odds, type: :model do
  let(:odds) { create(:odds) }

  describe 'association' do
    subject { odds }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { odds }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:ratio) }
  end
end

# == Schema Information
#
# Table name: odds
#
#  betting_method   :integer          not null, primary key
#  betting_number   :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  ratio            :float(24)        not null
#  stadium_tel_code :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
