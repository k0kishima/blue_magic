require 'rails_helper'

describe Kpi::Base, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:source) }

    describe 'validate to source' do
      subject { described_class.new(source: source) }

      context 'when a race object given as source' do
        let(:source) { build(:race) }

        it { is_expected.to have(0).error_on(:source) }
      end

      context 'when a not race object given as source' do
        let(:source) { build(:race_entry) }

        it { is_expected.to have(1).error_on(:source) }
      end
    end
  end
end
