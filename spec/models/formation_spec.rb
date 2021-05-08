require 'rails_helper'

describe Formation, type: :model do
  let(:formation) { described_class.new(candicate_pit_numbers_list) }

  describe '#betting_numbers' do
    subject { formation.betting_numbers }

    let(:candicate_pit_numbers_list) { [[1, 2], [1, 2], [1, 2, 3, 4, 5, 6]] }

    it 'returns betting_numbers' do
      expect(subject).to eq [123, 124, 125, 126, 213, 214, 215, 216]
    end
  end
end
