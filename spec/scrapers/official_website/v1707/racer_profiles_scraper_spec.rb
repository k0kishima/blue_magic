require 'rails_helper'

describe OfficialWebsite::V1707::RacerProfilesScraper do
  shared_examples :cacheable do
    it 'データ取得結果をキャッシュすること' do
      expect(subject).to eq scraper.cache
    end
  end

  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(file: file) }

    context 'ファイルがセットされているとき' do
      let(:file) { File.new(file_path, 'r') }

      context 'レーサーのプロフィールページがファイルとして引数として渡されたとき' do
        context 'レーサーのデータが存在する場合' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/4444/profile.html" }

          it 'データが取得できること' do
            expect(subject).to eq([{
                                    last_name: '桐生',
                                    first_name: '順平',
                                    registration_number: 4444,
                                    birth_date: '1986-10-07',
                                    height: 160,
                                    weight: 53,
                                    branch_prefecture: '埼玉',
                                    born_prefecture: '福島県',
                                    term: 100,
                                    current_rating: 'A1級'
                                  }])
          end

          it_behaves_like :cacheable
        end

        context 'レーサーのデータが存在しない場合' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/retired.html" }

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

    context 'ファイルがセットされていないとき' do
      let(:file) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
