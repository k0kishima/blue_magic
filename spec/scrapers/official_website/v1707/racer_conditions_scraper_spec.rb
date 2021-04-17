require 'rails_helper'

describe OfficialWebsite::V1707::RacerConditionsScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context 'レース直前情報ページのファイルが引数として渡されたとき' do
      context '欠場艇がいないとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_23#_1R.html"
        }

        it '全艇のデータが取得できること' do
          expect(subject).to contain_exactly({
                                               pit_number: 1,
                                               racer_registration_number: 4096,
                                               weight: 52.5,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 2,
                                               racer_registration_number: 4693,
                                               weight: 51.0,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 3,
                                               racer_registration_number: 2505,
                                               weight: 50.0,
                                               adjust: 1.0,
                                             },
                                             {
                                               pit_number: 4,
                                               racer_registration_number: 4803,
                                               weight: 54.4,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 5,
                                               racer_registration_number: 3138,
                                               weight: 51.9,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 6,
                                               racer_registration_number: 4221,
                                               weight: 50.0,
                                               adjust: 1.0,
                                             })
        end
      end

      context '欠場艇が存在するとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_03#_11R.html"
        }

        it '欠場艇を除いてデータが取得できること' do
          expect(subject).to contain_exactly({
                                               pit_number: 2,
                                               racer_registration_number: 3880,
                                               weight: 55.8,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 3,
                                               racer_registration_number: 3793,
                                               weight: 56.5,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 4,
                                               racer_registration_number: 4357,
                                               weight: 52.8,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 5,
                                               racer_registration_number: 4037,
                                               weight: 51.2,
                                               adjust: 0.0,
                                             },
                                             {
                                               pit_number: 6,
                                               racer_registration_number: 3797,
                                               weight: 58.3,
                                               adjust: 0.0,
                                             })
        end
      end
    end

    context 'レース直前情報ページではないファイルが引数として渡されたとき' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/monthly_schedule/2015_11.html" }

      it 'エラーが発生すること' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
