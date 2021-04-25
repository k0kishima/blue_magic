require 'rails_helper'

describe OddsListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/odds_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        data = subject
        expect(data.count).to eq 120
        expect(data.first).to eq({
                                   date: Date.new(2017, 9, 19), stadium_tel_code: 19, race_number: 11,
                                   betting_method: :trifecta, betting_number: 123, ratio: 6.1,
                                 })
        expect(data.last).to eq({
                                  date: Date.new(2017, 9, 19), stadium_tel_code: 19, race_number: 11,
                                  betting_method: :trifecta, betting_number: 654, ratio: 0.0,
                                })
      end
    end
  end
end
