require 'rails_helper'

describe OfficialWebsite::V1707::BoatSettingsScraper do
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
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 2,
                                                 racer_registration_number: 4693,
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 2505,
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 4803,
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 3138,
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 4221,
                                                 tilt: -0.5,
                                                 is_new_propeller: false,
                                               })
          end

          it_behaves_like :cacheable
        end

        context '欠場艇が存在するとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_03#_11R.html"
          }

          it '欠場艇も含めてデータ取得できること' do
            expect(subject).to contain_exactly({
                                                 pit_number: 1,
                                                 racer_registration_number: 3872,
                                                 tilt: nil,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 2,
                                                 racer_registration_number: 3880,
                                                 tilt: 0.0,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 3,
                                                 racer_registration_number: 3793,
                                                 tilt: 0.0,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 4,
                                                 racer_registration_number: 4357,
                                                 tilt: 0.0,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 5,
                                                 racer_registration_number: 4037,
                                                 tilt: 0.0,
                                                 is_new_propeller: false,
                                               },
                                               {
                                                 pit_number: 6,
                                                 racer_registration_number: 3797,
                                                 tilt: 0.5,
                                                 is_new_propeller: false,
                                               })
          end

          it_behaves_like :cacheable
        end

        context 'プロペラの変更があるとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2018_06_19_04#_4R.html"
          }

          it 'プロペラの変更も含めてパースされること' do
            expect(subject.map { |d| d[:is_new_propeller] }).to eq([false, false, false, true, false, false])
          end

          it_behaves_like :cacheable
        end

        context '情報が不完全な場合' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2020_06_30_12#_12R.html"
          }

          it 'raises data not found exception' do
            expect { subject }.to raise_error(::DataNotFound)
          end
        end
      end

      context 'レース直前情報ページ・レース結果情報ページ以外のファイルが引数として渡されたとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2015_08_25.html"
        }

        it { expect { subject }.to raise_error(StandardError) }
      end
    end

    context 'ファイルがセットされていないとき' do
      let(:file) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
