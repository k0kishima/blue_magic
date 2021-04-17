require 'rails_helper'

describe OfficialWebsite::V1707::RacerProfileScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context 'レーサーのプロフィールページがファイルとして引数として渡されたとき' do
      context 'レーサーのデータが存在する場合' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/4444/profile.html" }

        it 'データが取得できること' do
          expect(subject).to eq({
                                  last_name: '桐生',
                                  first_name: '順平',
                                  registration_number: 4444,
                                  birth_date: '1986-10-07',
                                  height: 160,
                                  weight: 52,
                                  branch_prefecture: '埼玉',
                                  born_prefecture: '福島県',
                                  term: 100,
                                  current_rating: 'A1級'
                                })
        end
      end

      context 'レーサーのデータが存在しない場合' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/retired.htm" }

        it 'DataNotFound例外が発生すること' do
          expect { subject }.to raise_error(::DataNotFound)
        end
      end
    end

    context 'レーサーのプロフィールページではないファイルが引数として渡されたとき' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/monthly_schedule/2015_11.html" }

      it 'エラーが発生すること' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
