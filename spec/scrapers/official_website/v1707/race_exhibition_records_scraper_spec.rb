require 'rails_helper'

describe OfficialWebsite::V1707::RaceExhibitionRecordsScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context 'レース直前情報ページのファイルが引数として渡されたとき' do
      context '欠場艇がいないとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_23#_1R.html"
        }

        it '全艇データ取得できること' do
          expect(subject).to contain_exactly({
                                               pit_number: 1,
                                               racer_registration_number: 4096,
                                               exhibition_time: 6.7,
                                               exhibition_time_order: 1,
                                               start_course: 1,
                                               start_time: 0.23,
                                               is_flying: false
                                             },
                                             {
                                               pit_number: 2,
                                               racer_registration_number: 4693,
                                               exhibition_time: 6.81,
                                               exhibition_time_order: 2,
                                               start_course: 2,
                                               start_time: 0.28,
                                               is_flying: false
                                             },
                                             {
                                               pit_number: 3,
                                               racer_registration_number: 2505,
                                               exhibition_time: 6.84,
                                               exhibition_time_order: 5,
                                               start_course: 3,
                                               start_time: 0.21,
                                               is_flying: false
                                             },
                                             {
                                               pit_number: 4,
                                               racer_registration_number: 4803,
                                               exhibition_time: 6.86,
                                               exhibition_time_order: 6,
                                               start_course: 4,
                                               start_time: 0.21,
                                               is_flying: false
                                             },
                                             {
                                               pit_number: 5,
                                               racer_registration_number: 3138,
                                               exhibition_time: 6.83,
                                               exhibition_time_order: 4,
                                               start_course: 5,
                                               start_time: 0.11,
                                               is_flying: false
                                             },
                                             {
                                               pit_number: 6,
                                               racer_registration_number: 4221,
                                               exhibition_time: 6.81,
                                               exhibition_time_order: 2,
                                               start_course: 6,
                                               start_time: 0.04,
                                               is_flying: true
                                             })
        end

        context '欠場艇が存在するとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_03#_11R.html"
          }

          it '欠場艇を除いてデータ取得できること' do
            expect(subject).to contain_exactly({
                                                 pit_number: 2,
                                                 racer_registration_number: 3880,
                                                 exhibition_time: 6.91,
                                                 exhibition_time_order: 2,
                                                 start_course: 1,
                                                 start_time: 0.21,
                                                 is_flying: false
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 3793,
                                                 exhibition_time: 7.04,
                                                 exhibition_time_order: 4,
                                                 start_course: 2,
                                                 start_time: 0.21,
                                                 is_flying: false
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 4357,
                                                 exhibition_time: 7.0,
                                                 exhibition_time_order: 3,
                                                 start_course: 3,
                                                 start_time: 0.08,
                                                 is_flying: false
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 4037,
                                                 exhibition_time: 7.16,
                                                 exhibition_time_order: 5,
                                                 start_course: 4,
                                                 start_time: 0.08,
                                                 is_flying: false
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 3797,
                                                 exhibition_time: 6.78,
                                                 exhibition_time_order: 1,
                                                 start_course: 5,
                                                 start_time: 0.32,
                                                 is_flying: false
                                               })
          end
        end
      end
    end

    context 'レース直前情報ページではないファイルが引数として渡されたとき' do
      let(:file_path) {
        "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2015_08_25.html"
      }

      it 'エラーが発生すること' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
