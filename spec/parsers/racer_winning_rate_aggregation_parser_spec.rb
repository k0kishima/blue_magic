require 'rails_helper'

describe RacerWinningRateAggregationParser do
  describe '#parse!' do
    subject { parser.parse! }

    let(:csv) { File.new(file_path, 'r') }
    let(:parser) { described_class.new(csv) }

    context 'when csv format is valid' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/csv/race_entry_list/just_required_columns.csv" }

      it 'returns array of dict as result of csv parsing' do
        expect(subject).to contain_exactly(
          { :racer_registration_number => 4190, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 7.02, :rate_in_event_going_stadium => 8.82 },
          { :racer_registration_number => 4240, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 5.66, :rate_in_event_going_stadium => 0.0 },
          { :racer_registration_number => 4419, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 5.36, :rate_in_event_going_stadium => 4.38 },
          { :racer_registration_number => 3175, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 6.0, :rate_in_event_going_stadium => 5.71 },
          { :racer_registration_number => 3254, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 3.18, :rate_in_event_going_stadium => 5.78 },
          { :racer_registration_number => 4843, :aggregated_on => Date.new(2018, 3, 1),
            :rate_in_all_stadium => 1.78, :rate_in_event_going_stadium => 2.39 }
        )
      end
    end
  end
end
