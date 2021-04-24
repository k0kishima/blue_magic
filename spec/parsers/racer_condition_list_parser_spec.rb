require 'rails_helper'

describe RacerConditionListParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/racer_condition_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>4096, :weight=>52.5, :adjust=>0.0},
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>4693, :weight=>51.0, :adjust=>0.0},
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>2505, :weight=>50.0, :adjust=>1.0},
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>4803, :weight=>54.4, :adjust=>0.0},
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>3138, :weight=>51.9, :adjust=>0.0},
          {:date=>Date.new(2015, 11, 16), :racer_registration_number=>4221, :weight=>50.0, :adjust=>1.0}
        )
      end
    end
  end
end
