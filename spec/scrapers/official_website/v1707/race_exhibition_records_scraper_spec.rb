require 'rails_helper'

describe OfficialWebsite::V1707::RaceExhibitionRecordsScraper do
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
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 1,
                                                 racer_registration_number: 4096,
                                                 exhibition_time: 6.7,
                                                 exhibition_time_order: 1,
                                                 start_course: 1,
                                                 start_time: 0.23,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 2,
                                                 racer_registration_number: 4693,
                                                 exhibition_time: 6.81,
                                                 exhibition_time_order: 2,
                                                 start_course: 2,
                                                 start_time: 0.28,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 3,
                                                 racer_registration_number: 2505,
                                                 exhibition_time: 6.84,
                                                 exhibition_time_order: 5,
                                                 start_course: 3,
                                                 start_time: 0.21,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 4,
                                                 racer_registration_number: 4803,
                                                 exhibition_time: 6.86,
                                                 exhibition_time_order: 6,
                                                 start_course: 4,
                                                 start_time: 0.21,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 5,
                                                 racer_registration_number: 3138,
                                                 exhibition_time: 6.83,
                                                 exhibition_time_order: 4,
                                                 start_course: 5,
                                                 start_time: 0.11,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 23,
                                                 race_number: 1,
                                                 pit_number: 6,
                                                 racer_registration_number: 4221,
                                                 exhibition_time: 6.81,
                                                 exhibition_time_order: 2,
                                                 start_course: 6,
                                                 start_time: 0.04,
                                                 is_flying: true,
                                                 is_lateness: false,
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
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 3,
                                                 race_number: 11,
                                                 pit_number: 2,
                                                 racer_registration_number: 3880,
                                                 exhibition_time: 6.91,
                                                 exhibition_time_order: 2,
                                                 start_course: 1,
                                                 start_time: 0.21,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 3,
                                                 race_number: 11,
                                                 pit_number: 3,
                                                 racer_registration_number: 3793,
                                                 exhibition_time: 7.04,
                                                 exhibition_time_order: 4,
                                                 start_course: 2,
                                                 start_time: 0.21,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 3,
                                                 race_number: 11,
                                                 pit_number: 4,
                                                 racer_registration_number: 4357,
                                                 exhibition_time: 7.0,
                                                 exhibition_time_order: 3,
                                                 start_course: 3,
                                                 start_time: 0.08,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 3,
                                                 race_number: 11,
                                                 pit_number: 5,
                                                 racer_registration_number: 4037,
                                                 exhibition_time: 7.16,
                                                 exhibition_time_order: 5,
                                                 start_course: 4,
                                                 start_time: 0.08,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               },
                                               {
                                                 date: Date.new(2015, 11, 16),
                                                 stadium_tel_code: 3,
                                                 race_number: 11,
                                                 pit_number: 6,
                                                 racer_registration_number: 3797,
                                                 exhibition_time: 6.78,
                                                 exhibition_time_order: 1,
                                                 start_course: 5,
                                                 start_time: 0.32,
                                                 is_flying: false,
                                                 is_lateness: false,
                                               })
          end

          it_behaves_like :cacheable
        end

        context '展示に参加しなかった艇が存在するとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_06_25_06#_10R.html"
          }

          xit '不参加の艇も含めて取得できること' do
          end
        end

        context '出遅れが発生したとき' do
          context '進入自体は正常にできている場合' do
            let(:file_path) {
              "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_06_02_13#_5R.html"
            }

            it '出遅れも含めてデータ取得できること' do
              expect(subject).to contain_exactly(
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 1,
                  :racer_registration_number => 4175,
                  :exhibition_time => 6.88,
                  :start_course => 1,
                  :start_time => 0.21,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 5 },
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 2,
                  :racer_registration_number => 4169,
                  :exhibition_time => 6.88,
                  :start_course => 2,
                  :start_time => 0.42,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 5 },
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 3,
                  :racer_registration_number => 3925,
                  :exhibition_time => 6.72,
                  :start_course => 3,
                  :start_time => 0.33,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 1 },
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 4,
                  :racer_registration_number => 4571,
                  :exhibition_time => 6.76,
                  :start_course => 4,
                  :start_time => nil,
                  :is_flying => nil,
                  :is_lateness => true,
                  :exhibition_time_order => 2 },
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 5,
                  :racer_registration_number => 4277,
                  :exhibition_time => 6.8,
                  :start_course => 5,
                  :start_time => 0.33,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 4 },
                { :date => Date.new(2017, 6, 2),
                  :stadium_tel_code => 13,
                  :race_number => 5,
                  :pit_number => 6,
                  :racer_registration_number => 4172,
                  :exhibition_time => 6.79,
                  :start_course => 6,
                  :start_time => 0.29,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 3 }
              )
            end
          end

          context '進入も正常にできていない場合' do
            let(:file_path) {
              "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_05_11_17#_2R.html"
            }

            it '出遅れも含めてデータ取得できること' do
              expect(subject).to contain_exactly(
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 1,
                  :racer_registration_number => 4348,
                  :exhibition_time => 6.65,
                  :start_course => 6,
                  :start_time => nil,
                  :is_flying => nil,
                  :is_lateness => true,
                  :exhibition_time_order => 4 },
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 2,
                  :racer_registration_number => 3573,
                  :exhibition_time => 6.54,
                  :start_course => 1,
                  :start_time => 0.07,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 1 },
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 3,
                  :racer_registration_number => 3780,
                  :exhibition_time => 6.59,
                  :start_course => 2,
                  :start_time => 0.05,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 2 },
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 4,
                  :racer_registration_number => 4468,
                  :exhibition_time => 6.64,
                  :start_course => 3,
                  :start_time => 0.17,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 3 },
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 5,
                  :racer_registration_number => 4168,
                  :exhibition_time => 6.66,
                  :start_course => 4,
                  :start_time => 0.04,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 5 },
                { :date => Date.new(2017, 5, 11),
                  :stadium_tel_code => 17,
                  :race_number => 2,
                  :pit_number => 6,
                  :racer_registration_number => 4350,
                  :exhibition_time => 6.69,
                  :start_course => 5,
                  :start_time => 0.06,
                  :is_flying => false,
                  :is_lateness => false,
                  :exhibition_time_order => 6 }
              )
            end
          end
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
