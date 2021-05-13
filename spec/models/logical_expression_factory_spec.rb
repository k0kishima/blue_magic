require 'rails_helper'

class RaceMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :race_number, :integer

  attr_accessor :stadium, :race_entries
  alias race_entry race_entries
end

class RaceEntryMock
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :pit_number, :integer
  attribute :performance_score, :float
end

RSpec.describe LogicalExpressionFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(hash) }

    describe 'to create from not nested structure' do
      let(:race) do
        race = RaceMock.new
        race.race_entries = [
          RaceEntryMock.new(pit_number: 1, performance_score: 10),
          RaceEntryMock.new(pit_number: 4, performance_score: 12.1)
        ]
        race
      end

      let(:hash) do
        {
          and: [
            {
              '<=': [
                { item: :race_entry, modifier: [:pit_number, 1], attr: :performance_score },
                { item: :literal, value: 10 }
              ]
            },
            {
              '>': [
                { item: :race_entry, modifier: [:pit_number, 4], attr: :performance_score },
                { item: :literal, value: 12 }
              ]
            }
          ]
        }
      end

      it 'returns lambda which is able to return boolean' do
        expression = subject
        expect(expression.call(race)).to be true
      end
    end

    describe 'to create from not nested structure' do
      let(:race) do
        race = RaceMock.new
        race.race_entries = [
          RaceEntryMock.new(pit_number: 1, performance_score: 10),
          RaceEntryMock.new(pit_number: 2, performance_score: 9),
          RaceEntryMock.new(pit_number: 3, performance_score: 15),
          RaceEntryMock.new(pit_number: 4, performance_score: 12.1)
        ]
        race
      end

      let(:hash) do
        {
          or: [
            {
              and: [
                {
                  '<=': [
                    { item: :race_entry, modifier: [:pit_number, 1], attr: :performance_score },
                    { item: :literal, value: 10 }
                  ]
                },
                {
                  '>': [
                    { item: :race_entry, modifier: [:pit_number, 4], attr: :performance_score },
                    { item: :literal, value: 12 }
                  ]
                }
              ]
            },
            {
              and: [
                {
                  '<': [
                    { item: :race_entry, modifier: [:pit_number, 2], attr: :performance_score },
                    { item: :literal, value: 10 }
                  ]
                },
                {
                  '<': [
                    { item: :race_entry, modifier: [:pit_number, 3], attr: :performance_score },
                    { item: :literal, value: 10 }
                  ]
                }
              ]
            }
          ]
        }
      end

      it 'returns lambda which is able to return boolean' do
        expression = subject
        expect(expression.call(race)).to be true
      end
    end

    context 'when invalid structured hash given' do
      let(:hash) do
        { item: :racer, modifier: [:pit_number, 1], attr: :in_nige_succeed_rate }
      end
      let(:race) { RaceMock.new }

      it 'raises ArgumentError error if execute created lambda' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
