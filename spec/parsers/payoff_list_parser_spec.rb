require 'rails_helper'

describe PayoffListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/payoff_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2015, 11, 15), :stadium_tel_code => 7, :race_number => 12,
            :betting_method => "trifecta", :betting_number => 435, :amount => 56670 },
        )
      end
    end
  end
end
