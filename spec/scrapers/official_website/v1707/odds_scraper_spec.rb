require 'rails_helper'

describe OfficialWebsite::V1707::OddsScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context 'オッズ情報ページのファイルが引数として渡されたとき' do
      context 'レースが中止されたとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/odds/trifecta/2018_01_03_03#_11R.html"
        }

        it { expect { subject }.to raise_error(::RaceCanceled) }
      end

      context 'データが公開されていないとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/odds/trifecta/2017_01_02_01#_1R.html"
        }

        it { expect { subject }.to raise_error(::DataNotFound) }
      end

      context '3連単をパースするとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/odds/trifecta/2017_09_19_19#_11R.html"
        }

        it 'オッズがパースされること' do
          parsed_data = subject
          expect(parsed_data.count).to eq 120
          expect(parsed_data.first).to eq({ betting_number: 123, ratio: 6.1, })
        end

        it '欠場艇は倍率0.0で取得されること' do
          parsed_data = subject
          expect(parsed_data.last).to eq({ betting_number: 654, ratio: 0.0, })
        end
      end
    end

    context 'オッズ情報ページ以外のファイルが引数として渡されたとき' do
      let(:file_path) {
        "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2015_11_15_07#_12R.html"
      }

      it { expect { subject }.to raise_error(StandardError) }
    end
  end
end
