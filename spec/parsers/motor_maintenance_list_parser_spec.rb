require 'rails_helper'

describe MotorMaintenanceListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/motor_maintenance_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :piston, :quantity => 2 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :piston_ring, :quantity => 4 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :carburetor, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :cylinder, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :gear_case, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 38, :exchanged_parts => :carrier_body, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 16, :exchanged_parts => :piston, :quantity => 2 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 16, :exchanged_parts => :piston_ring, :quantity => 4 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 16, :exchanged_parts => :cylinder, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 16, :exchanged_parts => :gear_case, :quantity => 1 },
          { :date => Date.new(2021, 4, 20), :stadium_tel_code => 19, :race_number => 12,
            :motor_number => 16, :exchanged_parts => :carrier_body, :quantity => 1 }
        )
      end
    end
  end
end
