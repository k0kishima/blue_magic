require 'rails_helper'

describe OfficialWebsite::ScheduleRaceDataCrawlingJob, type: :job do
  describe '#perform_now' do
    subject { described_class.perform_now(date: date, version: version) }

    context 'when use version "1707"' do
      let(:version) { '1707' }
      let(:date) { Date.new(2021, 4, 6) }

      context 'when a date before today or today was specified' do
        context 'when races exist in specified date' do
          let!(:race_1) { create(:race, date: date, stadium_tel_code: 3, race_number: 1) }
          let!(:race_2) { create(:race, date: date, stadium_tel_code: 4, race_number: 1) }
          let(:race_count) { Race.where(date: date).count }

          before do
            ActiveJob::Base.queue_adapter = :test
          end

          it 'invokes CrawlRaceInformationsJob exactly races count' do
            expect { subject }.to have_enqueued_job(OfficialWebsite::CrawlRaceInformationsJob).exactly(race_count).times
          end

          it 'invokes CrawlRaceExhibitionInformationsJob exactly races count' do
            expect {
              subject
            }.to have_enqueued_job(OfficialWebsite::CrawlRaceExhibitionInformationsJob).exactly(race_count).times
          end

          it 'invokes CrawlRaceResultsJob exactly races count' do
            expect { subject }.to have_enqueued_job(OfficialWebsite::CrawlRaceResultsJob).exactly(race_count).times
          end

          it 'invokes CrawlOddsJob exactly races count' do
            expect { subject }.to have_enqueued_job(OfficialWebsite::CrawlOddsJob).exactly(race_count).times
          end

          it 'invokes CrawlBoatSettingsJob exactly races count' do
            expect { subject }.to have_enqueued_job(OfficialWebsite::CrawlBoatSettingsJob).exactly(race_count).times
          end
        end

        context 'when races do not exist in specified date' do
          it { expect { subject }.to raise_error(ArgumentError) }
        end
      end

      context 'when a date after tomorrow was specified' do
        let(:date) { Date.tomorrow }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
