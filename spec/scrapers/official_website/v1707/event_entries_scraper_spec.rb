require 'rails_helper'

describe OfficialWebsite::V1707::EventEntriesScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context '前検情報ページのファイルが引数として渡されたとき' do
      context 'データが存在しないとき' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_entry/2020_08_08_17#.html" }

        it { expect { subject }.to raise_error(::DataNotFound) }
      end

      context '通常の節の場合' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_entry/2015_11_07_23#.html" }

        it 'データが取得できること' do
          parsed_data = subject
          expect(parsed_data.count).to eq 44
          expect(parsed_data.first).to eq({
                                            racer_registration_number: 3470,
                                            racer_last_name: '新田',
                                            racer_first_name: '芳美',
                                            racer_rank: 'A1',
                                            motor_number: 70,
                                            quinella_rate_of_motor: 61.6,
                                            boat_number: 35,
                                            quinella_rate_of_boat: 39.2,
                                            anterior_time: 7.07,
                                            racer_gender: 'female',
                                          })
          expect(parsed_data.last).to eq({
                                           racer_registration_number: 3518,
                                           racer_last_name: '倉田',
                                           racer_first_name: '郁美',
                                           racer_rank: 'A2',
                                           motor_number: 44,
                                           quinella_rate_of_motor: 20.3,
                                           boat_number: 36,
                                           quinella_rate_of_boat: 31.7,
                                           anterior_time: 6.96,
                                           racer_gender: 'female',
                                         })
        end
      end

      context 'ダブル開催の時（チャレンジカップもしくはグランプリ)' do
        describe 'グランプリでのスクレイピング' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_entry/2019_12_18_12#.html" }

          it 'データが取得できること' do
            parsed_data = subject
            expect(parsed_data.count).to eq 59
            expect(parsed_data.first).to eq({
                                              :racer_registration_number => 4320,
                                              :racer_last_name => "峰",
                                              :racer_first_name => "竜太",
                                              :racer_rank => "A1",
                                              :motor_number => 88,
                                              :quinella_rate_of_motor => 56.8,
                                              :boat_number => 26,
                                              :quinella_rate_of_boat => 45.9,
                                              :anterior_time => 6.7,
                                              :racer_gender => "male"
                                            })
            expect(parsed_data.last).to eq({
                                             :racer_registration_number => 3942,
                                             :racer_last_name => "寺田",
                                             :racer_first_name => "祥",
                                             :racer_rank => "A1",
                                             :motor_number => 29,
                                             :quinella_rate_of_motor => 25.7,
                                             :boat_number => 87,
                                             :quinella_rate_of_boat => 35.6,
                                             :anterior_time => 6.76,
                                             :racer_gender => "male"
                                           })
          end
        end
      end

      describe 'チャレンジカップでのスクレイピング' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_entry/2019_11_19_01#.html" }

        it 'parses event entries' do
          parsed_data = subject
          expect(parsed_data.count).to eq 54
          expect(parsed_data.first).to eq({ :racer_registration_number => 4075,
                                            :racer_last_name => "中野",
                                            :racer_first_name => "次郎",
                                            :racer_rank => "A1",
                                            :motor_number => 29,
                                            :quinella_rate_of_motor => 53.6,
                                            :boat_number => 28,
                                            :quinella_rate_of_boat => 0.0,
                                            :anterior_time => 6.66,
                                            :racer_gender => "male" })
          expect(parsed_data.last).to eq({ :racer_registration_number => 4347,
                                           :racer_last_name => "魚谷",
                                           :racer_first_name => "香織",
                                           :racer_rank => "A2",
                                           :motor_number => 39,
                                           :quinella_rate_of_motor => 27.7,
                                           :boat_number => 51,
                                           :quinella_rate_of_boat => 0.0,
                                           :anterior_time => 6.79,
                                           :racer_gender => "female" })
        end
      end
    end

    context '前検情報ページ以外のファイルが引数として渡されたとき' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/4444/profile.html" }

      it 'エラーが発生すること' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
