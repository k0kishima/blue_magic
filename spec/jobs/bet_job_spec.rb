require 'rails_helper'

describe BetJob, type: :job do
  describe '#perform_now' do
    subject do
      described_class.perform_now(forecaster_id: forecaster.id, stadium_tel_code: race.stadium_tel_code,
                                  race_opened_on: race.date, race_number: race.race_number,)
    end

    let(:forecaster) { create(:forecaster, betting_strategy: betting_strategy) }
    let(:race) { create(:race) }

    before do
      stub_const('RankingSetting::RACE_ENTRY', [])
    end

    context 'when something forecasting patterns are matched' do
      let(:odds_1) { create(:odds, race: race, betting_number: 123, ratio: 9) }
      let(:odds_2) { create(:odds, race: race, betting_number: 124, ratio: 10) }

      before do
        allow_any_instance_of(Forecaster).to receive(:forecast!).and_return([odds_1, odds_2])
      end

      context 'when betting strategy is :take_the_first_forecasting_pattern' do
        let(:betting_strategy) { :take_the_first_forecasting_pattern }
        let(:betting_strategy_double) { class_double(BettingStrategy::TakeTheFirstForecastingPattern) }
        let(:betting_strategy_instance_double) { instance_double(BettingStrategy::TakeTheFirstForecastingPattern) }

        before do
          stub_const('BettingStrategy::TakeTheFirstForecastingPattern', betting_strategy_double)
          allow(betting_strategy_double).to receive(:new).and_return(betting_strategy_instance_double)
          allow(betting_strategy_instance_double).to receive(:bet!).and_return(true)
        end

        it 'bets by the strategy' do
          subject
          expect(betting_strategy_instance_double).to have_received(:bet!).once
        end
      end

      context 'when betting strategy is :take_all_forecasting_patterns' do
        let(:betting_strategy) { :take_all_forecasting_patterns }
        let(:betting_strategy_double) { class_double(BettingStrategy::TakeAllForecastingPatterns) }
        let(:betting_strategy_instance_double) { instance_double(BettingStrategy::TakeAllForecastingPatterns) }

        before do
          stub_const('BettingStrategy::TakeAllForecastingPatterns', betting_strategy_double)
          allow(betting_strategy_double).to receive(:new).and_return(betting_strategy_instance_double)
          allow(betting_strategy_instance_double).to receive(:bet!).and_return(true)
        end

        it 'bets by the strategy' do
          subject
          expect(betting_strategy_instance_double).to have_received(:bet!).once
        end
      end

      context 'when betting strategy is :take_all_forecasting_patterns_without_duplication' do
        let(:betting_strategy) { :take_all_forecasting_patterns_without_duplication }
        let(:betting_strategy_double) { class_double(BettingStrategy::TakeAllForecastingPatternsWithoutDuplication) }
        let(:betting_strategy_instance_double) {
          instance_double(BettingStrategy::TakeAllForecastingPatternsWithoutDuplication)
        }

        before do
          stub_const('BettingStrategy::TakeAllForecastingPatternsWithoutDuplication', betting_strategy_double)
          allow(betting_strategy_double).to receive(:new).and_return(betting_strategy_instance_double)
          allow(betting_strategy_instance_double).to receive(:bet!).and_return(true)
        end

        it 'bets by the strategy' do
          subject
          expect(betting_strategy_instance_double).to have_received(:bet!).once
        end
      end
    end

    context 'when forecasting patterns did not match' do
      let(:betting_strategy) { :take_the_first_forecasting_pattern }

      it 'does not perform job' do
        assert_no_performed_jobs do
          subject
        end
      end
    end
  end
end
