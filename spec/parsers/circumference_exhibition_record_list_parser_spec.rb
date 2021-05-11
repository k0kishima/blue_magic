require 'rails_helper'

describe CircumferenceExhibitionRecordListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/2015_11_16_23#_1R.csv" }

      context 'when all entries had done exhibition normally' do
        it 'returns array of dict as result of csv parsing' do
          expect(subject).to contain_exactly(
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 1, :exhibition_time => 6.7, :exhibition_time_order => 1 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 2, :exhibition_time => 6.81, :exhibition_time_order => 2 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 3, :exhibition_time => 6.84, :exhibition_time_order => 5 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 4, :exhibition_time => 6.86, :exhibition_time_order => 6 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 5, :exhibition_time => 6.83, :exhibition_time_order => 4 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 6, :exhibition_time => 6.81, :exhibition_time_order => 2 }
          )
        end
      end

      context 'when all entries had not done exhibition normally' do
        context 'when someone had been lateness' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/2017_05_11_17#_2R.csv" }

          it 'returns array of dict as result of csv parsing which includes lateness entries' do
            expect(subject).to contain_exactly(
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 1, :exhibition_time => 6.65, :exhibition_time_order => 4 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 2, :exhibition_time => 6.54, :exhibition_time_order => 1 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 3, :exhibition_time => 6.59, :exhibition_time_order => 2 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 4, :exhibition_time => 6.64, :exhibition_time_order => 3 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 5, :exhibition_time => 6.66, :exhibition_time_order => 5 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 6, :exhibition_time => 6.69, :exhibition_time_order => 6 }
            )
          end
        end

        context 'when someone absent the start exhibition' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/2017_06_25_06#_10R.csv" }

          it 'returns array of dict as result of csv parsing which includes absented entries' do
            expect(subject).to contain_exactly(
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 1, :exhibition_time => 6.66, :exhibition_time_order => 1 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 2, :exhibition_time => 6.76, :exhibition_time_order => 5 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 3, :exhibition_time => 6.71, :exhibition_time_order => 2 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 4, :exhibition_time => 6.77, :exhibition_time_order => 6 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 5, :exhibition_time => 6.73, :exhibition_time_order => 3 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 6, :exhibition_time => 6.73, :exhibition_time_order => 3 }
            )
          end
        end
      end
    end
  end
end
