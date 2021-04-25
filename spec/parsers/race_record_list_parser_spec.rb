require 'rails_helper'

describe RaceRecordListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_record_list/just_required_columns.csv" }

      # TODO: 失格者をrejectしてあったりするが、ケースごとにサンプルを分ける
      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 1, :course_number => 1,
            :start_time => 0.06, :start_order => 1, :race_time => 110.9, :arrival => 2 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 3, :course_number => 3,
            :start_time => 0.22, :start_order => 4, :race_time => 112.5, :arrival => 3 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 4, :course_number => 4,
            :start_time => 0.21, :start_order => 3, :race_time => 109.9, :arrival => 1 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 5, :course_number => 5,
            :start_time => 0.23, :start_order => 5, :race_time => 113.5, :arrival => 4 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 9, :race_number => 7,
            :pit_number => 6, :course_number => 2,
            :start_time => 0.1, :start_order => 2, :race_time => nil, :arrival => 5 }
        )
      end
    end
  end
end
