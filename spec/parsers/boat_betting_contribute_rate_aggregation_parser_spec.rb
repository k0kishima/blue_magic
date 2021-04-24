require 'rails_helper'

describe BoatBettingContributeRateAggregationParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_entry_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :stadium_tel_code => 7, :boat_number => 40, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 39.18, :trio_rate => 57.22 },
          { :stadium_tel_code => 7, :boat_number => 43, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 37.65, :trio_rate => 55.29 },
          { :stadium_tel_code => 7, :boat_number => 74, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 35.62, :trio_rate => 54.79 },
          { :stadium_tel_code => 7, :boat_number => 13, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 29.78, :trio_rate => 45.51 },
          { :stadium_tel_code => 7, :boat_number => 65, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 27.43, :trio_rate => 50.86 },
          { :stadium_tel_code => 7, :boat_number => 68, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 29.49, :trio_rate => 45.35 }
        )
      end
    end
  end
end
