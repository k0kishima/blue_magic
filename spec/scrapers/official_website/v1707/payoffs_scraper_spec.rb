require 'rails_helper'

describe OfficialWebsite::V1707::PayoffsScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context 'レース結果情報ページのファイルが引数として渡されたとき' do
      context '返還がないとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2015_11_15_07#_12R.html"
        }

        it '勝舟番号と払戻金がパースされること' do
          expect(subject).to eq([{ betting_method: :trifecta, betting_number: "4-3-5", amount: 56670 },])
        end
      end

      context '欠場艇がいるとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2015_11_16_03#_11R.html"
        }

        it '勝舟番号と払戻金がパースされること' do
          expect(subject).to eq([{ betting_method: :trifecta, betting_number: "2-3-4", amount: 3100 },])
        end
      end

      context '2連単以外の式別が不成立のとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2015_11_14_02#_2R.html"
        }

        it { is_expected.to be_blank }
      end
    end

    context 'レース結果情報ページ以外のファイルが引数として渡されたとき' do
      let(:file_path) {
        "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2020_06_30_12#_12R.html"
      }

      it { expect { subject }.to raise_error(StandardError) }
    end
  end
end
