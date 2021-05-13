require 'rails_helper'

class RaceMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :race_number, :integer

  attr_accessor :stadium, :race_entries
  alias race_entry race_entries
end

class StadiumMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :tel_code, :integer
end

class RaceEntryMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :pit_number, :integer
  attribute :in_nige_succeed_rate, :float
end

RSpec.describe OperandProcessorFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(hash) }

    describe 'to create literal type operand' do
      let(:hash) do
        { item: :literal, value: [3, 4, 5] }
      end
      let(:race) do
        RaceMock.new
      end

      it 'returns lambda which is able to get value from object' do
        expression = subject
        expect(expression.call(race)).to eq [3, 4, 5]
      end
    end

    context 'when subject is race' do
      describe 'to create race type operand' do
        let(:hash) do
          { item: :itself, attr: :race_number }
        end
        let(:race) do
          RaceMock.new(race_number: 12)
        end

        it 'returns lambda which is able to get value from object' do
          expression = subject
          expect(expression.call(race)).to eq 12
        end
      end

      describe 'to create stadium type operand' do
        let(:hash) do
          { item: :stadium, attr: :tel_code }
        end
        let(:race) do
          race = RaceMock.new
          race.stadium = StadiumMock.new(tel_code: 4)
          race
        end

        it 'returns lambda which is able to get value from object' do
          expression = subject
          expect(expression.call(race)).to eq 4
        end
      end

      describe 'to create stadium type operand' do
        let(:hash) do
          { item: :race_entry, modifier: [:pit_number, 1], attr: :in_nige_succeed_rate }
        end
        let(:race) do
          race = RaceMock.new
          race.race_entries = [
            RaceEntryMock.new(pit_number: 1, in_nige_succeed_rate: 77.0),
            RaceEntryMock.new(pit_number: 2, in_nige_succeed_rate: nil)
          ]
          race
        end

        it 'returns lambda which is able to get value from object' do
          expression = subject
          expect(expression.call(race)).to eq 77.0
        end
      end

      context 'when unknown item specified' do
        let(:hash) do
          { item: :racer, modifier: [:pit_number, 1], attr: :in_nige_succeed_rate }
        end
        let(:race) do
          race = RaceMock.new
          race.race_entries = [
            RaceEntryMock.new(pit_number: 1, in_nige_succeed_rate: 77.0),
            RaceEntryMock.new(pit_number: 2, in_nige_succeed_rate: nil)
          ]
          race
        end

        it 'raises NoMethod error if execute created lambda' do
          expression = subject
          expect { expression.call(race) }.to raise_error NoMethodError
        end
      end
    end
  end
end
