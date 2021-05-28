require 'rails_helper'

RSpec.describe KpiCalculator::AttributionalCalculator, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:object) }
    it { is_expected.to validate_presence_of(:attribute_name) }
  end

  describe '#calculate!' do
    subject { calculator.calculate! }

    let(:calculator) { described_class.new(object: object, attribute_name: attribute_name) }

    context 'on the valid object' do
      let(:object) { build(:race, race_number: 1) }

      context 'when the specified attribute is present' do
        let(:attribute_name) { :race_number }

        it 'returns a value from the specified attribute on the specified object' do
          expect(subject).to eq 1
        end
      end

      context 'when the specified attribute is not present' do
        let(:attribute_name) { :foo_bar }

        it { expect { subject }.to raise_error(NoMethodError) }
      end
    end

    context 'on the invalid object' do
      let(:object) { nil }
      let(:attribute_name) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
