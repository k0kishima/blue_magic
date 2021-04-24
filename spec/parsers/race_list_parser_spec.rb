require 'rails_helper'

describe RaceListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly({
                                             :date => Date.new(2015, 10, 16),
                                             :stadium_tel_code => 8,
                                             :race_number => 2,
                                             :course_fixed => false,
                                             :use_stabilizer => false,
                                             :betting_deadline_at => Time.local(2015, 10, 16, 11, 13).to_datetime,
                                             :title => "予選",
                                             :number_of_laps => 3
                                           },
                                           {
                                             :date => Date.new(2015, 1, 1),
                                             :stadium_tel_code => 24,
                                             :race_number => 12,
                                             :course_fixed => true,
                                             :use_stabilizer => true,
                                             :betting_deadline_at => Time.local(2015, 1, 1, 20, 33).to_datetime,
                                             :title => "ドリーム",
                                             :number_of_laps => 2
                                           })
      end
    end
  end
end
