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

  describe '#create_recommend_odds_of!' do
    subject { forecasters_forecasting_pattern.create_recommend_odds_of!(race) }

    let(:forecasters_forecasting_pattern) {
      create(:forecasters_forecasting_pattern, budget_amount_per_race: 10_000, composition_odds: 5.0)
    }
    let(:race) { create(:race) }
    let(:odds_1) { create(:odds, race: race, betting_number: 123, ratio: 9) }
    let(:odds_2) { create(:odds, race: race, betting_number: 124, ratio: 10) }
    let(:odds_3) { create(:odds, race: race, betting_number: 213, ratio: 20) }

    before do
      allow(forecasters_forecasting_pattern.forecasting_pattern).to receive(:recommend_odds_of).and_return(
        [odds_1, odds_2]
      )
    end

    context 'when OverBudget exception not happened' do
      before do
        allow_any_instance_of(FundAllocationService).to receive(:call).and_return({
                                                                                    123 => 51,
                                                                                    124 => 49,
                                                                                  })
      end

      context 'when recommend odds of the race does not exist yet' do
        it 'creates recommend odds' do
          expect { subject }.to change { RecommendOdds.count }.by(2)
          expect(RecommendOdds.all).to contain_exactly(
            have_attributes(
              forecasters_forecasting_pattern_id: forecasters_forecasting_pattern.id,
              stadium_tel_code: race.stadium_tel_code,
              date: race.date,
              race_number: race.race_number,
              betting_method: 'trifecta',
              betting_number: 123,
              ratio_when_forecasting: 9.0,
              should_purchase_quantity: 51,
            ),
            have_attributes(
              forecasters_forecasting_pattern_id: forecasters_forecasting_pattern.id,
              stadium_tel_code: race.stadium_tel_code,
              date: race.date,
              race_number: race.race_number,
              betting_method: 'trifecta',
              betting_number: 124,
              ratio_when_forecasting: 10.0,
              should_purchase_quantity: 49,
            ),
          )
        end
      end

      context 'when recommend odds of the race already exist' do
        before do
          create(:recommend_odds,
                 forecasters_forecasting_pattern_id: forecasters_forecasting_pattern.id,
                 stadium_tel_code: race.stadium_tel_code,
                 date: race.date,
                 race_number: race.race_number,)
        end

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotUnique) }
      end
    end

    context 'when OverBudget exception happened' do
      before do
        allow_any_instance_of(FundAllocationService).to receive(:call).and_raise(OverBudget)
      end

      it 'returns an empty array' do
        expect(subject).to eq([])
      end
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
