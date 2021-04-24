require 'rails_helper'

describe RaceEntryListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_entry_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>4190, :pit_number=>1},
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>4240, :pit_number=>2},
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>4419, :pit_number=>3},
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>3175, :pit_number=>4},
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>3254, :pit_number=>5},
          {:date=>Date.new(2018, 3, 1), :stadium_tel_code=>7, :race_number=>8, :racer_registration_number=>4843, :pit_number=>6})
      end
    end
  end
end

