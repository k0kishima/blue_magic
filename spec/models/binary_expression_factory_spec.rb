require 'rails_helper'

class RaceMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :race_number, :integer

  attr_accessor :stadium, :race_entries
end

class StadiumMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :tel_code, :integer
end

RSpec.describe BinaryExpressionFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(hash) }

    context 'when invalid format hash given' do
      let(:hash) do
        { item: :stadium, attr: :tel_code }
      end

      it 'raises ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when valid format hash given' do
      describe 'boolean operation' do
        let(:hash) do
          { in?: [{ item: :stadium, attr: :tel_code }, { item: :literal, value: [3, 4, 5] }] }
        end
        let(:race_1) do
          race = RaceMock.new
          race.stadium = StadiumMock.new(tel_code: 4)
          race
        end
        let(:race_2) do
          race = RaceMock.new
          race.stadium = StadiumMock.new(tel_code: 6)
          race
        end

        it 'returns lambda which is able to express value from object' do
          expression = subject
          expect(expression.call(race_1)).to be true
          expect(expression.call(race_2)).to be false
        end
      end

      describe 'numerical calculation' do
        let(:hash) do
          { '+' => [{ item: :stadium, attr: :tel_code }, { item: :itself, attr: :race_number }] }
        end

        let(:race_1) do
          race = RaceMock.new(race_number: 12)
          race.stadium = StadiumMock.new(tel_code: 4)
          race
        end

        it 'returns lambda which is able to express value from object' do
          expression = subject
          expect(expression.call(race_1)).to eq 16
        end
      end

      describe 'nested hash processing' do
        let(:race_1) do
          race = RaceMock.new(race_number: 1)
          race.stadium = StadiumMock.new(tel_code: 4)
          race
        end

        let(:hash) do
          {
            '>' => [
              { item: :stadium, attr: :tel_code },
              {
                '+' => [
                  { item: :stadium, attr: :tel_code },
                  { item: :itself, attr: :race_number }
                ]
              }
            ]
          }
        end

        it 'returns lambda which is able to express value from object' do
          expression = subject
          expect(expression.call(race_1)).to be false
        end
      end
    end
  end
end
