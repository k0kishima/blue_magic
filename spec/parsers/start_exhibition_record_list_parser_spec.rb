require 'rails_helper'

describe StartExhibitionRecordListParser do
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
              :pit_number => 1, :course_number => 1, :start_time => 0.23 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 2, :course_number => 2, :start_time => 0.28 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 3, :course_number => 3, :start_time => 0.21 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 4, :course_number => 4, :start_time => 0.21 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 5, :course_number => 5, :start_time => 0.11 },
            { :date => Date.new(2015, 11, 16), :stadium_tel_code => 23, :race_number => 1,
              :pit_number => 6, :course_number => 6, :start_time => -0.04 }
          )
        end
      end

      context 'when all entries had not done exhibition normally' do
        context 'when someone had been lateness' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/2017_05_11_17#_2R.csv" }

          it 'returns array of dict as result of csv parsing which includes lateness entries' do
            expect(subject).to contain_exactly(
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 1, :course_number => 6, :start_time => 1.01 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 2, :course_number => 1, :start_time => 0.07 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 3, :course_number => 2, :start_time => 0.05 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 4, :course_number => 3, :start_time => 0.17 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 5, :course_number => 4, :start_time => 0.04 },
              { :date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                :pit_number => 6, :course_number => 5, :start_time => 0.06 }
            )
          end

          it 'saves lateness entry by st 1.01' do
            lateness_entry = subject.find { |hash| hash[:pit_number] == 1 }
            expect(lateness_entry[:start_time]).to eq 1.01
          end
        end

        context 'when someone absent the start exhibition' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_exhibition_record_list/2017_06_25_06#_10R.csv" }

          it 'returns array of dict as result of csv parsing which excludes absented entries' do
            expect(subject).to contain_exactly(
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 1, :course_number => 1, :start_time => 0.02 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 2, :course_number => 2, :start_time => 0.32 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 3, :course_number => 3, :start_time => 0.05 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 4, :course_number => 4, :start_time => 0.19 },
              { :date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                :pit_number => 6, :course_number => 5, :start_time => 0.16 }
            )
          end
        end
      end
    end
  end
end
