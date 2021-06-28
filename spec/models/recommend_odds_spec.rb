require 'rails_helper'

RSpec.describe RecommendOdds, type: :model do
  let(:recommend_odds) { create(:recommend_odds, :with_forecasters_forecasting_pattern) }

  describe 'association' do
    subject { recommend_odds }

    it { is_expected.to belong_to(:forecasters_forecasting_pattern) }
    it { is_expected.to have_one(:betting) }
  end

  describe 'validations' do
    subject { recommend_odds }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:ratio_when_forecasting) }
    it { is_expected.to validate_presence_of(:should_purchase_quantity) }
  end
end

# == Schema Information
#
# Table name: recommend_odds
#
#  forecasters_forecasting_pattern_id :bigint           not null, primary key
#  stadium_tel_code                   :integer          not null, primary key
#  date                               :date             not null, primary key
#  race_number                        :integer          not null, primary key
#  betting_method                     :integer          not null
#  betting_number                     :integer          not null, primary key
#  ratio_when_forecasting             :float(24)        not null
#  should_purchase_quantity           :integer          not null
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
