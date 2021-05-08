require 'rails_helper'

describe ForecastersForecastingPattern, type: :model do
  let(:forecasters_forecasting_pattern) { create(:forecasters_forecasting_pattern) }

  describe 'association' do
    subject { forecasters_forecasting_pattern }

    it { is_expected.to belong_to(:forecaster) }
    it { is_expected.to belong_to(:forecasting_pattern) }
  end

  describe 'validations' do
    subject { forecasters_forecasting_pattern }

    it { is_expected.to validate_presence_of(:budget_amount_per_race) }
    it { is_expected.to validate_presence_of(:fund_allocation_method) }
    it { is_expected.to validate_presence_of(:composition_odds) }
  end

  describe '#target_amount' do
    subject { forecasters_forecasting_pattern.target_amount }

    let(:forecasters_forecasting_pattern) {
      create(:forecasters_forecasting_pattern, budget_amount_per_race: 10_000, composition_odds: 7.5)
    }

    it 'returns budget_amount_per_race times composition_odds' do
      expect(subject).to eq 75_000
    end
  end
end

# == Schema Information
#
# Table name: forecasters_forecasting_patterns
#
#  id                     :bigint           not null, primary key
#  forecaster_id          :bigint
#  forecasting_pattern_id :bigint
#  budget_amount_per_race :integer          not null
#  fund_allocation_method :integer          not null
#  composition_odds       :float(24)        not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  foreign_key_1  (forecaster_id)
#  foreign_key_2  (forecasting_pattern_id)
#  uniq_index_1   (forecaster_id,forecasting_pattern_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (forecaster_id => forecasters.id)
#  fk_rails_...  (forecasting_pattern_id => forecasting_patterns.id)
#
