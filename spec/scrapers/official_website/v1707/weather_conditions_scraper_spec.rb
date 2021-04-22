require 'rails_helper'

describe OfficialWebsite::V1707::WeatherConditionsScraper do
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
        context '情報が欠損している時' do
          context '0:00時点の観測結果のとき' do
            let(:file_path) {
              "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_10_30_03#_1R.html"
            }

            it { expect { subject }.to raise_error(::DataNotFound) }
          end

          context 'レースが中止されているとき' do
            let(:file_path) {
              "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_10_30_03#_9R.html"
            }

            it { expect { subject }.to raise_error(::DataNotFound) }
          end
        end

        context '異常気象ではないとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_15_07#_12R.html"
          }

          it 'データが取得できること' do
            expect(subject).to eq([{
                                    weather: '晴',
                                    wavelength: 2.0,
                                    wind_angle: 315.0,
                                    wind_velocity: 4.0,
                                    air_temperature: 17.0,
                                    water_temperature: 17.0,
                                  }])
          end

          it_behaves_like :cacheable
        end

        context '台風のとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2017_10_22_07#_1R.html"
          }

          it { expect { subject }.to_not raise_error(::UnknownDataDetected) }
        end
      end

      context 'レース結果のページが与えられたとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2018_11_16_18#_7R.html"
        }

        context 'レースが終了しているとき' do
          it 'データが取得できること' do
            expect(subject).to eq([{
                                    weather: '曇り',
                                    wavelength: 1.0,
                                    wind_angle: 135.0,
                                    wind_velocity: 1.0,
                                    air_temperature: 15.0,
                                    water_temperature: 18.0,
                                  }])
          end

          it_behaves_like :cacheable
        end

        context 'レースが中止されているとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_result/2018_08_05_03#_8R.html"
          }

          it { expect { subject }.to raise_error(::RaceCanceled) }
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
