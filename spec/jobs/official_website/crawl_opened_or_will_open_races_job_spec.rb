require 'rails_helper'

describe OfficialWebsite::CrawlOpenedOrWillOpenRacesJob, type: :job do
  subject { described_class.perform_now(date: date) }

  describe '#perform_now' do
    let(:event_holding) { EventHolding.new(stadium_tel_code: 4, date: date) }

    before do
      stub_const("#{described_class}::SLEEP_SECOND", 0)
      allow(EventHolding).to receive(:opened_on).and_return([event_holding])
      allow(ImportDataQueueFactory).to receive(:create!)
    end

    context 'when a date before today or today was specified' do
      let(:date) { Date.today }

      it 'invokes ImportDataJob once' do
        expect(ImportDataQueueFactory).to receive(:create!).once
        subject
      end
    end

    context 'when a date after tomorrow was specified' do
      let(:date) { Date.tomorrow }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
