require 'rails_helper'

describe BoatSettingListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    # TODO: 欠場艇のデータは保存されないことを検証するサンプルを追加する
    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/boat_setting_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 1,
            :boat_number => 39, :motor_number => 50, :tilt => 0.0, :propeller_renewed => true },
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 2,
            :boat_number => 37, :motor_number => 15, :tilt => 0.0, :propeller_renewed => false },
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 3,
            :boat_number => 46, :motor_number => 33, :tilt => 0.0, :propeller_renewed => false },
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 4,
            :boat_number => 22, :motor_number => 40, :tilt => 0.5, :propeller_renewed => true },
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 5,
            :boat_number => 54, :motor_number => 10, :tilt => 0.5, :propeller_renewed => true },
          { :date => Date.new(2021, 4, 23), :stadium_tel_code => 3, :race_number => 12, :pit_number => 6,
            :boat_number => 57, :motor_number => 13, :tilt => 0.5, :propeller_renewed => false }
        )
      end
    end
  end
end
