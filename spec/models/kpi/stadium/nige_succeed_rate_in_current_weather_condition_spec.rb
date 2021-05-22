require 'rails_helper'

describe Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition, type: :model do
  let(:kpi) { described_class.new }

  describe '#value!' do
    subject { kpi.value! }

    context 'when source is present' do
      let(:race) { create(:race) }

      before do
        kpi.source = race
      end

      context 'when race has weather information in exhibition' do
        let!(:weather_condition_in_exhibition) { create(:weather_condition, race: race, in_performance: false) }

        it 'returns value' do
          expect(subject).to eq 0
        end
      end

      context 'when race does not have weather information in exhibition' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    context 'when source is blank' do
      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
