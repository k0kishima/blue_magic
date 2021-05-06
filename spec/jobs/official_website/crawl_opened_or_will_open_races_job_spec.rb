require 'rails_helper'

describe OfficialWebsite::CrawlOpenedOrWillOpenRacesJob, type: :job do
  include_context 'with a mocked slack client'

  subject { described_class.perform_now(date: date) }

  describe '#perform_now' do
    let(:event_holding) { EventHolding.new(stadium_tel_code: 4, date: date) }

    before do
      stub_const("#{described_class}::SLEEP_SECOND", 0)
      allow(EventHolding).to receive(:opened_on).and_return([event_holding])
    end

    context 'when crawling enabled' do
      include_context 'with crawling enable setting'

      context 'when a date before today or today was specified' do
        let(:date) { Date.today }

        it 'invokes CrawlRaceInformationsJob exactly races count' do
          expect { subject }.to have_enqueued_job(OfficialWebsite::CrawlRaceInformationsJob).exactly(12).times
          subject
        end
      end

      context 'when a date after tomorrow was specified' do
        let(:date) { Date.tomorrow }

        it 'does not perform job' do
          assert_no_performed_jobs do
            subject
          end
        end
      end
    end

    context 'when crawling disabled' do
      include_context 'with crawling disable setting'

      let(:date) { nil }

      it 'does not perform job' do
        assert_no_performed_jobs do
          subject
        end
      end
    end
  end
end
