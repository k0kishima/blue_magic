require 'rails_helper'

describe RaceExhibitionRecordsParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 1, :course_number => 1,
            :start_time => 0.23, :exhibition_time => 6.7, :exhibition_time_order => 1 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 2, :course_number => 2,
            :start_time => 0.28, :exhibition_time => 6.81, :exhibition_time_order => 2 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 3, :course_number => 3,
            :start_time => 0.21, :exhibition_time => 6.84, :exhibition_time_order => 5 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 4, :course_number => 4,
            :start_time => 0.21, :exhibition_time => 6.86, :exhibition_time_order => 6 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 5, :course_number => 5,
            :start_time => 0.11, :exhibition_time => 6.83, :exhibition_time_order => 4 },
          { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
            :pit_number => 6, :course_number => 6,
            :start_time => -0.04, :exhibition_time => 6.81, :exhibition_time_order => 2 }
        )
      end
    end
  end
end
