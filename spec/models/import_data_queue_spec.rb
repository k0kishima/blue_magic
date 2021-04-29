require 'rails_helper'

RSpec.describe ImportDataQueue, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:file_data) }

    describe 'file' do
      subject { build(:import_data_queue, file: file, status: :waiting_to_start) }

      let(:file) { Rack::Test::UploadedFile.new('spec/fixtures/uploadable/documents/sample.csv', 'text/csv') }

      before do
        allow(file).to receive(:size).and_return(filesize)
      end

      context 'when file size is less than or equal to 100MB' do
        let(:filesize) { 100.megabytes }

        it { is_expected.to be_valid }
      end

      context 'when file size is greater than 100MB' do
        let(:filesize) { 100.megabytes + 1 }

        it { is_expected.to be_invalid }
      end
    end
  end
end

# == Schema Information
#
# Table name: import_data_queues
#
#  id             :bigint           not null, primary key
#  status         :integer          default("waiting_to_start"), not null
#  file_data      :json             not null
#  error_messages :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
