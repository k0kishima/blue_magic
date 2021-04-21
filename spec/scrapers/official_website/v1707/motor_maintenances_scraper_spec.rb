require 'rails_helper'

describe OfficialWebsite::V1707::MotorMaintenancesScraper do
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

      context 'レース直前情報ページのファイルが引数として渡されたとき' do
        context '欠場艇がいないとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_23#_1R.html"
          }

          it '全艇データ取得できること' do
            expect(subject).to contain_exactly({
                                                 pit_number: 1,
                                                 racer_registration_number: 4096,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 2,
                                                 racer_registration_number: 4693,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 2505,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 4803,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 3138,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 4221,
                                                 parts_exchanges: [],
                                               })
          end

          it_behaves_like :cacheable
        end

        context '欠場艇が存在するとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_03#_11R.html"
          }

          it '欠場艇を除いてデータ取得できること' do
            expect(subject).to contain_exactly({
                                                 pit_number: 2,
                                                 racer_registration_number: 3880,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 3793,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 4357,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 4037,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 3797,
                                                 parts_exchanges: [],
                                               })
          end

          it_behaves_like :cacheable
        end

        context 'モーターの部品交換があるとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_23#_12R.html"
          }

          it '部品交換情報も含めてデータ取得できること' do
            expect(subject).to contain_exactly({
                                                 pit_number: 1,
                                                 racer_registration_number: 3200,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 2,
                                                 racer_registration_number: 4096,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 4163,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 3757,
                                                 parts_exchanges: [],
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 3963,
                                                 parts_exchanges: [
                                                   { parts_name: 'ピストン', count: 2 },
                                                   { parts_name: 'リング', count: 3 },
                                                   { parts_name: '電気',     count: 1 },
                                                   { parts_name: 'ギヤ',     count: 1 }
                                                 ],
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 4365,
                                                 parts_exchanges: [],
                                               })
          end

          it_behaves_like :cacheable
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

    context 'ファイルがセットされていないとき' do
      let(:file) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
