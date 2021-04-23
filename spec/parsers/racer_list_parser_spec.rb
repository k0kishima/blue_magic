require 'rails_helper'

describe RacerListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/racer_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly({
                                             :last_name => "桐生",
                                             :first_name => "順平",
                                             :registration_number => 4444,
                                             :term => 100,
                                             :birth_date => Date.new(1986, 10, 7),
                                             :branch_id => 11,
                                             :birth_prefecture_id => 7,
                                             :height => 161
                                           })
      end
    end
  end
end
