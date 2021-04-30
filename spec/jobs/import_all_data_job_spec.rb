require 'rails_helper'

describe ImportAllDataJob, type: :job do
  describe '#perform_now' do
    subject { described_class.perform_now }

    let!(:not_startable_queues) do
      [
        create(:import_data_queue, :with_sample_csv, status: :waiting_to_start),
        create(:import_data_queue, :with_sample_csv, status: :in_progress),
        create(:import_data_queue, :with_sample_csv, status: :success),
        create(:import_data_queue, :with_sample_csv, status: :failure),
      ]
    end

    context 'when startable queues exist' do
      let!(:startable_queues) do
        3.times.map {
          create(:import_data_queue, :with_sample_csv, status: :uploaded)
        }
      end

      before do
        ActiveJob::Base.queue_adapter = :test
      end

      it 'invokes ImportDataJob exactly startable_queues count' do
        expect { subject }.to have_enqueued_job(ImportDataJob).exactly(3).times
      end
    end

    context 'when startable queues do not exist' do
      it 'does not invoke ImportDataJob' do
        subject

        expect(ImportDataJob).not_to receive(:perform_later)
      end
    end
  end
end
