require 'rails_helper'

describe OfficialWebsite::CrawlRacerProfilesJob, type: :job do
  include_context 'with a mocked slack client'

  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/racer_profile' do
        described_class.perform_now(racer_registration_number: racer_registration_number, version: version)
      end
    end

    context 'when use version "1707"' do
      let(:version) { '1707' }
      let(:racer_registration_number) { 4444 }

      it 'saves racer profiles' do
        expect { subject }.to change { Racer.count }.by(1)
        expect(Racer.all).to contain_exactly(
          have_attributes(
            registration_number: 4444,
            last_name: '桐生',
            first_name: '順平',
            gender: nil,
            term: 100,
            birth_date: Date.new(1986, 10, 7),
            branch_id: 11,
            birth_prefecture_id: 7,
            height: 161,
            status: nil,
          )
        )
      end
    end
  end
end
