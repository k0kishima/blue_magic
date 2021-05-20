require 'rails_helper'

describe Kpi::RaceEntry::NigashiRate, type: :model do
  let(:kpi) { described_class.instance }

  describe '#aggregate!' do
    subject { kpi.aggregate!(source: source, aggregation_range: aggregate_starts_on..aggregate_ends_on) }

    let(:aggregate_starts_on) { Date.new(2020, 12, 1) }
    let(:aggregate_ends_on) { Date.new(2020, 12, 3) }

    context 'when a race entry given' do
      let(:source) { create(:race_entry) }

      context 'when the race entry has exhibition data' do
        before do
          create(:start_exhibition_record, course_number: 2, **source.attributes.slice(*RaceEntry.primary_keys))
        end

        it 'returns a kpi aggregation' do
          expect(subject).to have_attributes(
            kpi: kpi,
            value: 0,
            aggregate_starts_on: aggregate_starts_on,
            aggregate_ends_on: aggregate_ends_on,
          )
        end
      end

      context 'when the race entry does not have exhibition data yet' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    context 'when a object which is not race entry given' do
      let(:source) {
        create(:race_record, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 4,
                             course_number: 1, arrival: 1)
      }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
