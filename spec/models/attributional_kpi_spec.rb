require 'rails_helper'

describe AttributionalKpi, type: :model do
  let(:kpi) { Kpi.find_by(attribute_name: 'is_special_race') }

  describe '#value!' do
    subject { kpi.value! }

    context 'when an entry object is present' do
      before do
        kpi.entry_object = entry_object
      end

      context 'when the entry object is matched to specified class' do
        let(:entry_object) { build(:race, title: '特選') }

        it 'returns value' do
          expect(subject).to eq true
        end
      end

      context 'when the entry object is not matched to specified class' do
        let(:entry_object) { build(:racer) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end

    context 'when an entry object is blank' do
      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
