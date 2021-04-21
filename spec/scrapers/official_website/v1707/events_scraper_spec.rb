require 'rails_helper'

describe OfficialWebsite::V1707::EventsScraper do
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

      context '月間スケジュールページのファイルが引数として渡されたとき' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/monthly_schedule/2015_11.html" }
        let(:year)      { 2015 }
        let(:month)     { 11 }

        # rubocop:disable Layout/LineLength
        it 'データが取得できること' do
          expect(subject).to contain_exactly(
            { :stadium_tel_code => 1, :title => "第１０回公営レーシングプレス杯", :starts_on => Date.new(year, month, 5),
              :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 1, :title => "第１８回東京スポーツ杯",
              :starts_on => Date.new(year, month, 19), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 1, :title => "第１０回埼玉新聞社杯",
              :starts_on => Date.new(year, month, 28), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 2, :title => "戸田ルーキーシリーズ第７戦",
              :starts_on => Date.new(year, month, 7), :days => 6, :grade => 'no_grade', :kind => "rookie", },
            { :stadium_tel_code => 2, :title => "ＢＯＡＴＢｏｙＣＵＰ　１ｓｔ　ＲＯＵＮＤ", :starts_on => Date.new(year, month, 14),
              :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 2, :title => "ＢＰ岡部カップ開設１４周年記念・シニアＢＳ第４戦", :starts_on => Date.new(year, month, 21),
              :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 3, :title => "ヴィーナスシリーズ第７戦　江戸川ＪＩＮＲＯ　ＣＵＰ", :starts_on => Date.new(year, month, 1),
              :days => 6, :grade => 'no_grade', :kind => "venus", },
            { :stadium_tel_code => 3, :title => "第１６回日本財団会長杯",
              :starts_on => Date.new(year, month, 14), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 3, :title => "岡山支部大挙参戦！第３９回デイリースポーツ杯", :starts_on => Date.new(year, month, 27),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 4, :title => "第１４回府中市長杯",
              :starts_on => Date.new(year, month, 11), :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 4, :title => "第１５回夕刊フジ杯",
              :starts_on => Date.new(year, month, 22), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 5, :title => "第５２回サンケイスポーツ賞",
              :starts_on => Date.new(year, month, 3), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 5, :title => "ＧⅢ第１０回サントリーカップ",
              :starts_on => Date.new(year, month, 18), :days => 6, :grade => "g3", :kind => 'uncategorized', },
            { :stadium_tel_code => 6, :title => "新東通信杯",
              :starts_on => Date.new(year, month, 12), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 6, :title => "東海ｖｓ関東　中京スポーツもみじ杯", :starts_on => Date.new(year, month, 19),
              :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 6, :title => "公営レーシングプレスアタック", :starts_on => Date.new(year, month, 28),
              :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 7, :title => "ＢＯＡＴＢｏｙ　ＣＵＰ",
              :starts_on => Date.new(year, month, 1), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 7, :title => "ＧⅠオールジャパン竹島特別　開設６０周年記念競走", :starts_on => Date.new(year, month, 10),
              :days => 6, :grade => "g1", :kind => 'uncategorized', },
            { :stadium_tel_code => 7, :title => "第１０回蒲郡トトまるナイト特別", :starts_on => Date.new(year, month, 22),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 8, :title => "トリトン大賞",
              :starts_on => Date.new(year, month, 7), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 8, :title => "ＩＮＡＸ杯争奪第２７回ＧⅢとこなめ大賞", :starts_on => Date.new(year, month, 18),
              :days => 6, :grade => "g3", :kind => 'uncategorized', },
            { :stadium_tel_code => 8, :title => "第７回ＢＯＡＴＢｏｙカップ",
              :starts_on => Date.new(year, month, 27), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 9, :title => "鳥羽一郎杯争奪戦",
              :starts_on => Date.new(year, month, 3), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 9, :title => "中日スポーツ高虎杯争奪戦",
              :starts_on => Date.new(year, month, 12), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 9, :title => "トランスワード杯２０１５",
              :starts_on => Date.new(year, month, 22), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 10, :title => "ヴィーナスシリーズ第８戦　三国プリンセスカップ", :starts_on => Date.new(year, month, 13),
              :days => 6, :grade => 'no_grade', :kind => "venus", },
            { :stadium_tel_code => 10, :title => "しもつき第１戦",
              :starts_on => Date.new(year, month, 21), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 10, :title => "しもつき第２戦",
              :starts_on => Date.new(year, month, 28), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 11, :title => "びわこオータムカップ",
              :starts_on => Date.new(year, month, 8), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 11, :title => "紅葉特別",
              :starts_on => Date.new(year, month, 18), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 11, :title => "ＢＩＮＡＰＯ杯",
              :starts_on => Date.new(year, month, 28), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 12, :title => "グランプリ直前企画　坂上忍杯競走", :starts_on => Date.new(year, month, 7),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 12, :title => "サンケイスポーツ創刊６０周年記念第５８回ＧＳＳ競走", :starts_on => Date.new(year, month, 17),
              :days => 7, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 12, :title => "吹田市制７５周年記念競走",
              :starts_on => Date.new(year, month, 27), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 13, :title => "第６４回センタープール杯争奪ニッカングローリー賞", :starts_on => Date.new(year, month, 21),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 13, :title => "日刊スポーツ杯争奪　第２３回伊丹選手権競走", :starts_on => Date.new(year, month, 29),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 15, :title => "Ｂカードメンバー大感謝祭　日本トーター杯", :starts_on => Date.new(year, month, 6),
              :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 15, :title => "マンスリーＢＯＡＴＲＡＣＥ杯争奪　男女Ｗ優勝戦", :starts_on => Date.new(year, month, 13),
              :days => 6, :grade => 'no_grade', :kind => "double_winner", },
            { :stadium_tel_code => 15, :title => "第５回琴参バスカップ",
              :starts_on => Date.new(year, month, 24), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 16, :title => "第３１回日本モーターボート選手会会長杯", :starts_on => Date.new(year, month, 5),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 16, :title => "ＧⅠ児島キングカップ開設６３周年記念競走", :starts_on => Date.new(year, month, 14),
              :days => 6, :grade => "g1", :kind => 'uncategorized', },
            { :stadium_tel_code => 16, :title => "日刊スポーツ杯",
              :starts_on => Date.new(year, month, 24), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 17, :title => "ＧⅠ宮島チャンピオンカップ開設６１周年記念", :starts_on => Date.new(year, month, 4),
              :days => 6, :grade => "g1", :kind => 'uncategorized', },
            { :stadium_tel_code => 17, :title => "西日本スポーツ杯",
              :starts_on => Date.new(year, month, 15), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 17, :title => "代替開催３場対抗スカパー！・第１６回ＪＬＣ杯競走", :starts_on => Date.new(year, month, 27), :days => 6,
              :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 18, :title => "ニッカン・コム杯　徳山の陣",
              :starts_on => Date.new(year, month, 21), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 19, :title => "下関市議会議長杯争奪クリスタルカップ", :starts_on => Date.new(year, month, 7),
              :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 19, :title => "２０１５トランスワード杯争奪　男女Ｗ優勝戦", :starts_on => Date.new(year, month, 18),
              :days => 6, :grade => 'no_grade', :kind => "double_winner", },
            { :stadium_tel_code => 21, :title => "ＲＫＢラジオ杯",
              :starts_on => Date.new(year, month, 1), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 21, :title => "ＭＢＰ宮崎オープン１周年記念",
              :starts_on => Date.new(year, month, 13), :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 21, :title => "ＳＧ１８回チャレンジカップ／ＧⅡ２回レディースＣＣ", :starts_on => Date.new(year, month, 24),
              :days => 6, :grade => "sg", :kind => 'uncategorized', },
            { :stadium_tel_code => 22, :title => "スポーツ報知杯争奪戦",
              :starts_on => Date.new(year, month, 3), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 22, :title => "ＢＯＡＴ　Ｂｏｙカップ",
              :starts_on => Date.new(year, month, 12), :days => 5, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 22, :title => "日本モーターボート選手会長杯争奪戦", :starts_on => Date.new(year, month, 20),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 23, :title => "ＧⅢオールレディース　ＲＫＢラジオ杯", :starts_on => Date.new(year, month, 7),
              :days => 6, :grade => "g3", :kind => "all_ladies", },
            { :stadium_tel_code => 23, :title => "ＢＰみやき開設６周年記念　ＮＡＳカップ", :starts_on => Date.new(year, month, 15),
              :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 23, :title => "西日本スポーツ杯",
              :starts_on => Date.new(year, month, 27), :days => 6, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 24, :title => "ＢＴＳ鹿島開設記念競走",
              :starts_on => Date.new(year, month, 10), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
            { :stadium_tel_code => 24, :title => "富士通フロンテック杯",
              :starts_on => Date.new(year, month, 30), :days => 4, :grade => 'no_grade', :kind => 'uncategorized', },
          )
        end
        # rubocop:enable Layout/LineLength

        it_behaves_like :cacheable
      end

      context '月間スケジュールページではないファイルが引数として渡されたとき' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/4444/profile.html" }

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
