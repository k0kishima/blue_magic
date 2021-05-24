require 'rails_helper'

describe Kpi::Race::IsSpecialRace, type: :model do
  let(:kpi) { described_class.new(source: source) }

  describe '#value!' do
    subject { kpi.value! }

    context 'when source is present' do
      let(:source) { create(:race) }

      it 'returns boolean' do
        expect(subject).to be false
      end
    end

    context 'when source is blank' do
      let(:source) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
