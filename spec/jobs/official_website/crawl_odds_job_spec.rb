require 'rails_helper'

describe OfficialWebsite::CrawlOddsJob, type: :job do
  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/odds' do
        described_class.perform_now(
          stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
          version: version
        )
      end
    end

    context 'when use version "1707"' do
      let(:version) { '1707' }
      let(:stadium_tel_code) { 4 }
      let(:race_opened_on) { Date.new(2021, 4, 24) }
      let(:race_number) { 1 }

      it 'saves odds' do
        expect { subject }.to change { Odds.count }.by(120)
        all_odds = Odds.all
        expect(all_odds).to include(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            betting_method: 'trifecta',
            betting_number: 123,
            ratio: 44.7,
          )
        )
        expect(all_odds).to include(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            betting_method: 'trifecta',
            betting_number: 654,
            ratio: 397.6,
          )
        )
      end
    end
  end
end
