require 'rails_helper'

describe RacerCurrentSeriesPlacingRecordKpi, type: :model do
  describe '#value!' do
    subject { kpi.value! }

    let(:racer_registration_number) { 1 }
    let(:stadium_tel_code) { 4 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 23), stadium_tel_code: stadium_tel_code) }
    let(:race_2) { create(:race, date: Date.new(2021, 4, 30), stadium_tel_code: stadium_tel_code) }
    let(:race_3) { create(:race, date: Date.new(2021, 4, 30), stadium_tel_code: stadium_tel_code) }
    let(:race_4) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: stadium_tel_code) }
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_4) {
      create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }

    describe 'average' do
      let(:kpi) { Kpi.find_by(attribute_name: 'placing_average_in_current_series') }

      before do
        kpi.entry_object = race_entry_4
      end

      context 'when data prepared' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: stadium_tel_code)
        end

        context 'when race record exist' do
          before do
            create(:race_record, race_entry: race_entry_1, arrival: 1)
            create(:race_record, race_entry: race_entry_2, arrival: 1)
            create(:race_record, race_entry: race_entry_3, arrival: 3)
            create(:race_record, race_entry: race_entry_4, arrival: 5)
          end

          it 'returns placing average in current series' do
            expect(subject).to eq 2
          end
        end

        context 'when race record not exist' do
          it { expect { subject }.to raise_error(DataNotFound) }
        end
      end

      context 'when data not prepared' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe 'stdev' do
      let(:kpi) { Kpi.find_by(attribute_name: 'placing_stdev_in_current_series') }

      before do
        kpi.entry_object = race_entry_4
      end

      context 'when data prepared' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: stadium_tel_code)
        end

        context 'when race record exist' do
          before do
            create(:race_record, race_entry: race_entry_1, arrival: 1)
            create(:race_record, race_entry: race_entry_2, arrival: 1)
            create(:race_record, race_entry: race_entry_3, arrival: 3)
            create(:race_record, race_entry: race_entry_4, arrival: 5)
          end

          it 'returns placing average in current series' do
            expect(subject).to eq 1.4142135623730951
          end
        end

        context 'when race record not exist' do
          it { expect { subject }.to raise_error(DataNotFound) }
        end
      end

      context 'when data not prepared' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end
  end
end
