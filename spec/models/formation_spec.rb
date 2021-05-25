require 'rails_helper'

describe Formation, type: :model do
  let(:formation) { described_class.new(candicate_pit_numbers_list) }

  describe '#betting_numbers' do
    subject { formation.betting_numbers }

    context 'when given an array' do
      context 'when the array size is 3' do
        context 'when the array include numbers only' do
          let(:candicate_pit_numbers_list) { [[1, 2], [1, 2], [1, 2, 3, 4, 5, 6]] }

          it 'returns betting_numbers' do
            expect(subject).to eq [123, 124, 125, 126, 213, 214, 215, 216]
          end
        end

        context 'when the array include an empty array' do
          let(:candicate_pit_numbers_list) { [[], [1, 2], [1, 2, 3, 4, 5, 6]] }

          it 'returns blank array' do
            expect(subject).to eq []
          end
        end

        context 'when the array include empty arrays only' do
          let(:candicate_pit_numbers_list) { [[], [], []] }

          it 'returns blank array' do
            expect(subject).to eq []
          end
        end

        context 'when the array includes something not a number' do
          let(:candicate_pit_numbers_list) { [[1, 2], [1, 2], [1, 2, 3, 4, 5, "6"]] }

          it { expect { subject }.to raise_error(ArgumentError) }
        end
      end

      context 'when the array size is not 3' do
        let(:candicate_pit_numbers_list) { [[1, 2], [1, 2]] }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context 'when not given an array' do
      let(:candicate_pit_numbers_list) { "12-12-123456" }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
