require 'rails_helper'

describe BettingStrategy::TakeTheFirstForecastingPattern, type: :model do
  describe 'validations' do
    subject { betting_strategy }

    let(:betting_strategy) { described_class.new }
    it { is_expected.to validate_presence_of(:recommend_odds) }

    describe 'recommend_odds' do
      let(:betting_strategy) { described_class.new(recommend_odds: recommend_odds) }

      context 'when recommend odds have a betting' do
        let!(:a_recommend_odds) { create(:recommend_odds, :with_forecasters_forecasting_pattern, :with_betting) }
        let(:recommend_odds) { RecommendOdds.all }

        it { is_expected.to have(1).error_on(:recommend_odds) }
      end

      context 'when recommend odds does not have a betting' do
        let!(:a_recommend_odds) { create(:recommend_odds, :with_forecasters_forecasting_pattern) }
        let(:recommend_odds) { RecommendOdds.all }

        it { is_expected.to have(0).error_on(:recommend_odds) }
      end
    end
  end

  describe '#bet' do
    subject { betting_strategy.bet! }

    let(:betting_strategy) { described_class.new(recommend_odds: recommend_odds) }

    context 'when recommend odds are present' do
      context 'when have not bet yet' do
        let(:forecaster) { create(:forecaster) }
        let(:forecasting_pattern_1) { create(:forecasting_pattern) }
        let(:forecasting_pattern_2) { create(:forecasting_pattern) }
        let(:forecasters_forecasting_pattern_1) do
          create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_1,)
        end
        let(:forecasters_forecasting_pattern_2) do
          create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_2,)
        end
        let(:race) { create(:race) }
        let(:recommend_odds_1) do
          create(
            :recommend_odds,
            forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_1.id,
            **race.slice(*Race.primary_keys),
            betting_number: 123,
            ratio_when_forecasting: 10,
            should_purchase_quantity: 10
          )
        end
        let(:recommend_odds_2) do
          create(
            :recommend_odds,
            forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_2.id,
            **race.slice(*Race.primary_keys),
            betting_number: 124,
            ratio_when_forecasting: 20,
            should_purchase_quantity: 10
          )
        end
        let(:recommend_odds) { RecommendOdds.all }

        before do
          recommend_odds_1
          recommend_odds_2
        end

        it 'creates bettings of a forecasting pattern which has the oldest id' do
          expect { subject }.to change { Betting.count }.by(1)
          expect(Betting.all).to contain_exactly(
            have_attributes(
              forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_1.id,
              **race.slice(*Race.primary_keys),
              betting_method: 'trifecta',
              betting_number: 123,
              betting_amount: 1_000,
              dry_run: true,
            ),
          )
        end
      end

      context 'when already had bet' do
        let!(:a_recommend_odds) { create(:recommend_odds, :with_forecasters_forecasting_pattern, :with_betting) }
        let(:recommend_odds) { RecommendOdds.all }

        it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
      end
    end

    context 'when recommend odds are blank' do
      let(:recommend_odds) { [] }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
