require 'rails_helper'

describe MotorBettingContributeRateAggregationParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_entry_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :stadium_tel_code => 7, :motor_number => 66, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 38.1, :trio_rate => 51.9 },
          { :stadium_tel_code => 7, :motor_number => 41, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 36.5, :trio_rate => 51.0 },
          { :stadium_tel_code => 7, :motor_number => 58, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 33.17, :trio_rate => 51.49 },
          { :stadium_tel_code => 7, :motor_number => 33, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 39.72, :trio_rate => 55.61 },
          { :stadium_tel_code => 7, :motor_number => 71, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 29.51, :trio_rate => 46.72 },
          { :stadium_tel_code => 7, :motor_number => 40, :aggregated_on => Date.new(2018, 3, 1),
            :quinella_rate => 33.16, :trio_rate => 49.49 }
        )
      end
    end
  end
end
