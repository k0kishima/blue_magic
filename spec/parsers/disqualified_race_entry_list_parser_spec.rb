require 'rails_helper'

describe DisqualifiedRaceEntryListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_record_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 2, disqualification: :lateness },
        )
      end
    end
  end
end
