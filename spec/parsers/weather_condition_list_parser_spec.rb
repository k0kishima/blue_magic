require 'rails_helper'

describe WeatherConditionListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/weather_condition_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :date => Date.new(2015, 11, 15),
            :stadium_tel_code => 7,
            :race_number => 12,
            :in_performance => false,
            :weather => :fine,
            :wind_velocity => 2.0,
            :wind_angle => 315.0,
            :wavelength => 4.0,
            :air_temperature => 17.0,
            :water_temperature => 17.0 },
          { :date => Date.new(2018, 11, 16),
            :stadium_tel_code => 18,
            :race_number => 7,
            :in_performance => true,
            :weather => :cloudy,
            :wind_velocity => 1.0,
            :wind_angle => 135.0,
            :wavelength => 1.0,
            :air_temperature => 15.0,
            :water_temperature => 18.0 }
        )
      end
    end
  end
end
