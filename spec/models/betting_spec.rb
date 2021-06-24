require 'rails_helper'

describe Betting, type: :model do
  let(:betting) { create(:betting, :with_forecasters_forecasting_pattern) }

  describe 'association' do
    subject { betting }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { betting }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:betting_method) }
    it { is_expected.to validate_presence_of(:betting_number) }
    it { is_expected.to validate_presence_of(:betting_amount) }
    it { is_expected.to validate_presence_of(:voted_at) }
  end
end

# == Schema Information
#
# Table name: bettings
#
#  forecasters_forecasting_pattern_id :bigint           not null, primary key
#  stadium_tel_code                   :integer          not null, primary key
#  date                               :date             not null, primary key
#  race_number                        :integer          not null, primary key
#  betting_method                     :integer          not null
#  betting_number                     :integer          not null, primary key
#  betting_amount                     :integer          not null
#  refunded_amount                    :integer
#  adjustment_amount                  :integer
#  dry_run                            :boolean          not null
#  voted_at                           :datetime         not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
# Indexes
#
#  foreign_key_1  (forecasters_forecasting_pattern_id)
#
# Foreign Keys
#
#  fk_rails_...  (forecasters_forecasting_pattern_id => forecasters_forecasting_patterns.id)
#
