require 'rails_helper'

describe Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition, type: :model do
  let(:kpi) { described_class.new(pit_number: pit_number) }
  let(:pit_number) { 1 }

  describe '#value!' do
    subject { kpi.value! }

    context 'when source is present' do
      before do
        kpi.source = race
      end

      context 'when race entry is present' do
        let(:race) { create(:race, :with_race_entries) }

        context 'when race entry has start exhibition record' do
          let!(:start_exhibition_record) {
            create(:start_exhibition_record, **race.slice(*Race.primary_keys), pit_number: 1, course_number: 1)
          }

          it 'returns value' do
            expect(subject).to eq 0
          end
        end

        context 'when race entry does not have start exhibition record' do
          it { expect { subject }.to raise_error(DataNotPrepared) }
        end
      end

      context 'when race entry is not present' do
        let(:race) { create(:race) }

        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    context 'when source is blank' do
      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
