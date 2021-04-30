require 'rails_helper'

describe EventHolding, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe '.opened_on' do
    subject { described_class.opened_on(date) }

    let(:date) { Date.new(2015, 8, 25) }
    let(:file) { File.new(file_path, 'r') }
    let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2015_08_25.html" }
    let(:page_double) { class_double(OfficialWebsite::EventHoldingsPage) }
    let(:page_instance_double) { instance_double(OfficialWebsite::EventHoldingsPage) }

    before do
      stub_const('OfficialWebsite::EventHoldingsPage', page_double)
      allow(page_double).to receive(:new).and_return(page_instance_double)
      allow(page_instance_double).to receive(:file).and_return(file)
    end

    it 'returns event holdings' do
      # NOTE: ActiveRecordのインスタンスではないため、have_attributes は使えなかった
      expect(subject.map(&:attributes).map(&:symbolize_keys)).to contain_exactly(
        {
          stadium_tel_code: 3,
          date: date,
        },
        {
          stadium_tel_code: 4,
          date: date,
        },
        {
          stadium_tel_code: 7,
          date: date,
        },
        {
          stadium_tel_code: 11,
          date: date,
        },
      )
    end
  end
end
