require 'rails_helper'

describe CsvFactory do
  describe '.create' do
    subject { described_class.create!(args) }

    context 'when a array_of_hash given' do
      let(:args) { array_of_hash }

      context 'when there is no difference in hash structure' do
        let(:array_of_hash) {
          [
            { foo: 1, bar: 2 },
            { foo: 3, bar: 4 },
          ]
        }

        it 'creates csv' do
          csv = subject
          expect(csv.read).to eq "foo,bar\n1,2\n3,4\n"
        end
      end

      context 'when there is difference in hash structure' do
        let(:array_of_hash) {
          [
            { foo: 1, bar: 2 },
            { hoge: 3, bar: 4 },
          ]
        }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
