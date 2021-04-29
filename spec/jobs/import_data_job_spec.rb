require 'rails_helper'

describe ImportDataJob, type: :job do
  describe '#perform_now' do
    subject { described_class.perform_now(import_data_queue.id) }

    context 'when the queue status is :uploaded' do
      let(:import_data_queue) { create(:import_data_queue, :with_sample_csv, status: :uploaded) }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when the queue status is :in_progress' do
      let(:import_data_queue) { create(:import_data_queue, :with_sample_csv, status: :in_progress) }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when the queue status is :success' do
      let(:import_data_queue) { create(:import_data_queue, :with_sample_csv, status: :success) }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when the queue status is :failure' do
      let(:import_data_queue) { create(:import_data_queue, :with_sample_csv, status: :failure) }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when the queue status is :waiting_to_start' do
      let(:import_data_queue) { create(:import_data_queue, file: file, status: :waiting_to_start) }

      context 'when boat setting list uploaded' do
        let(:file) {
          Rack::Test::UploadedFile.new(
            'spec/fixtures/files/csv/boat_setting_list/just_required_columns.csv',
            'text/csv'
          )
        }

        it 'saves boat settings' do
          expect { subject }.to change { BoatSetting.count }.by(6)
          expect(BoatSetting.all).to contain_exactly(
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 1,
              :boat_number => 39, :motor_number => 50, :tilt => 0.0, :propeller_renewed => true
            ),
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 2,
              :boat_number => 37, :motor_number => 15, :tilt => 0.0, :propeller_renewed => false
            ),
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 3,
              :boat_number => 46, :motor_number => 33, :tilt => 0.0, :propeller_renewed => false
            ),
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 4,
              :boat_number => 22, :motor_number => 40, :tilt => 0.5, :propeller_renewed => true
            ),
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 5,
              :boat_number => 54, :motor_number => 10, :tilt => 0.5, :propeller_renewed => true
            ),
            have_attributes(
              :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 6,
              :boat_number => 57, :motor_number => 13, :tilt => 0.5, :propeller_renewed => false
            )
          )
        end

        it 'saves motor meintenances' do
          expect { subject }.to change { MotorMaintenance.count }.by(0)
        end
      end
    end
  end
end
