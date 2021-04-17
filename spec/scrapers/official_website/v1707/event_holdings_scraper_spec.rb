require 'rails_helper'

describe OfficialWebsite::V1707::EventHoldingsScraper do
  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(File.new(file_path, 'r')) }

    context '開催一覧情報ページのファイルが引数として渡されたとき' do
      context '全レースが終了しているとき' do
        context '中止や順延が発生しているとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2015_08_25.html"
          }

          it '中止や順延を含めた開催情報が取得できること' do
            expect(subject).to contain_exactly(
              { stadium_tel_code: 3, day_text: '３日目' },
              { stadium_tel_code: 4,  day_text: '最終日' },
              { stadium_tel_code: 7,  day_text: '初日'   },
              { stadium_tel_code: 11, day_text: '５日目'  },
              { stadium_tel_code: 16, day_text: '中止順延' },
              { stadium_tel_code: 18, day_text: '中止順延' },
              { stadium_tel_code: 19, day_text: '中止' },
              { stadium_tel_code: 20, day_text: '中止順延' },
              { stadium_tel_code: 22, day_text: '中止順延' },
              { stadium_tel_code: 23, day_text: '中止順延' },
              { stadium_tel_code: 24, day_text: '中止' }
            )
          end
        end

        context 'nR目以降が中止になっているとき' do
          let(:file_path) {
            "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2020_08_13.html"
          }

          it '途中から中止になった節は開催されているものとしてパースされること' do
            expect(subject).to contain_exactly(
              { :stadium_tel_code => 1, :day_text => "初日" },
              { :stadium_tel_code => 2, :day_text => "３日目" },
              { :stadium_tel_code => 3, :day_text => "初日" },
              { :stadium_tel_code => 6, :day_text => "初日" },
              { :stadium_tel_code => 7, :day_text => "初日" },
              { :stadium_tel_code => 10, :day_text => "最終日" },
              { :stadium_tel_code => 11, :day_text => "最終日" },
              { :stadium_tel_code => 12, :day_text => "中止" },
              { :stadium_tel_code => 13, :day_text => "５日目" },
              { :stadium_tel_code => 14, :day_text => "３日目" },
              { :stadium_tel_code => 17, :day_text => "２日目" },
              { :stadium_tel_code => 18, :day_text => "初日" },
              { :stadium_tel_code => 20, :day_text => "４日目" },
              { :stadium_tel_code => 22, :day_text => "３日目" },
              { :stadium_tel_code => 23, :day_text => "３日目" }
            )
          end
        end
      end

      context '発売中のレースがあるとき' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/2018_05_23.html" }

        it 'データが取得できること' do
          expect(subject).to contain_exactly(
            { :stadium_tel_code => 1, :day_text => '最終日' },
            { :stadium_tel_code => 2, :day_text => '２日目' },
            { :stadium_tel_code => 7, :day_text => '５日目' },
            { :stadium_tel_code => 8, :day_text => '最終日' },
            { :stadium_tel_code => 10, :day_text => '初日' },
            { :stadium_tel_code => 13, :day_text => '２日目' },
            { :stadium_tel_code => 14, :day_text => '４日目' },
            { :stadium_tel_code => 15, :day_text => '初日' },
            { :stadium_tel_code => 16, :day_text => '最終日' },
            { :stadium_tel_code => 17, :day_text => '３日目' },
            { :stadium_tel_code => 18, :day_text => '４日目' },
            { :stadium_tel_code => 20, :day_text => '３日目' },
            { :stadium_tel_code => 22, :day_text => '２日目' },
            { :stadium_tel_code => 24, :day_text => '５日目' }
          )
        end
      end

      context '前売りのレースがあるとき' do
        let(:file_path) {
          "#{Rails.root}/spec/fixtures/files/official_website/v1707/event_holding/pre_sale_presents.html"
        }

        it 'データが取得できること' do
          expect(subject).to contain_exactly(
            { :stadium_tel_code => 1, :day_text => "最終日" },
            { :stadium_tel_code => 2, :day_text => "４日目" },
            { :stadium_tel_code => 6, :day_text => "４日目" },
            { :stadium_tel_code => 7, :day_text => "２日目" },
            { :stadium_tel_code => 8, :day_text => "初日" },
            { :stadium_tel_code => 10, :day_text => "初日" },
            { :stadium_tel_code => 11, :day_text => "最終日" },
            { :stadium_tel_code => 13, :day_text => "４日目" },
            { :stadium_tel_code => 14, :day_text => "最終日" },
            { :stadium_tel_code => 16, :day_text => "３日目" },
            { :stadium_tel_code => 17, :day_text => "５日目" },
            { :stadium_tel_code => 19, :day_text => "初日" },
            { :stadium_tel_code => 20, :day_text => "４日目" },
            { :stadium_tel_code => 23, :day_text => "最終日" }
          )
        end
      end
    end

    context '開催一覧情報ページではないファイルが引数として渡されたとき' do
      let(:file_path) {
        "#{Rails.root}/spec/fixtures/files/official_website/v1707/race_before_information/2015_11_16_23#_1R.html"
      }
      it 'エラーが発生すること' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
