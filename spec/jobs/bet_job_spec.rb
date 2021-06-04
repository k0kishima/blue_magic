require 'rails_helper'

describe BetJob, type: :job do
  describe '#perform_now' do
    subject do
      described_class.perform_now(forecaster_id: forecaster.id, stadium_tel_code: race.stadium_tel_code,
                                  race_opened_on: race.date, race_number: race.race_number,)
    end

    let(:forecaster) { create(:forecaster, betting_strategy: betting_strategy) }
    let(:race) { create(:race) }

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
end
