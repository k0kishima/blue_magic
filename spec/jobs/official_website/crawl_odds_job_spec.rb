require 'rails_helper'

describe OfficialWebsite::CrawlOddsJob, type: :job do
  describe '#perform_now' do
    context 'when use version "1707"' do
      let(:version) { '1707' }

      context 'オッズが公開されているとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/odds/04_20210424_1R' do
            described_class.perform_now(
              stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
              version: version
            )
          end
        end

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

      context 'レースが中止されたとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/odds/02_20200316_7R' do
            described_class.perform_now(
              stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
              version: version
            )
          end
        end

        let(:stadium_tel_code) { 2 }
        let(:race_opened_on) { Date.new(2020, 3, 16) }
        let(:race_number) { 7 }

        it 'does not save odds' do
          expect { subject }.not_to change { Odds.count }
        end

        context 'レースの基本情報がすでに保存されているとき' do
          let!(:race) {
            create(:race, date: race_opened_on, stadium_tel_code: stadium_tel_code, race_number: race_number,
                          canceled: false)
          }

          it 'レースのステータスを更新するこt' do
            expect { subject }.to change { race.reload.canceled }.to(true).from(false)
          end
        end

        context 'レースの基本情報が存在しないとき' do
          let!(:other_race) {
            create(:race, date: race_opened_on, stadium_tel_code: stadium_tel_code, race_number: 1,
                          canceled: false)
          }

          it 'レースを更新しないこと' do
            expect { subject }.not_to change { other_race.canceled }
          end
        end
      end
    end
  end
end
