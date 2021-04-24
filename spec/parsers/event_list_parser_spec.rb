require 'rails_helper'

describe EventListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/event_list/just_required_columns.csv" }

      # 全件精査は無理なのでグレードと種別だけ網羅するように努める
      it 'returns array of dict as result of csv parsing' do
        data = subject
        expect(data.count).to eq 74
        expect(data).to include(
          { :stadium_tel_code => "6", :title => "オールレディースＨａｍａＺｏカップ", :starts_on => Date.new(2021, 4, 8),
            :grade => "g3", :kind => "all_ladies" }
        )
        expect(data).to include(
          { :stadium_tel_code => "12", :title => "ルーキーシリーズ第８戦　スカパー！・ＪＬＣ杯競走", :starts_on => Date.new(2021, 4, 14),
            :grade => "no_grade", :kind => "rookie" }
        )
        expect(data).to include(
          { :stadium_tel_code => "19", :title => "第２２回マスターズチャンピオン", :starts_on => Date.new(2021, 4, 20),
            :grade => "g1", :kind => "uncategorized" }
        )
      end
    end
  end
end
