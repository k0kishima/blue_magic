require 'rails_helper'

RSpec.describe RecommendOdds, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:recommended_by) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_presence_of(:betting_number) }
    it { is_expected.to validate_presence_of(:ratio) }
  end

  describe '#betting_numbers' do
    subject { recommended_formation.betting_numbers }

    let(:recommended_formation) { described_class.new(betting_number: 123) }

    it 'returns array of betting_number' do
      expect(subject).to eq [1, 2, 3]
    end
  end

  describe '#first' do
    subject { recommended_formation.first }

    let(:recommended_formation) { described_class.new(betting_number: 123) }

    it 'returns first element of betting_numbers' do
      expect(subject).to eq 1
    end
  end

  describe '#second' do
    subject { recommended_formation.second }

    let(:recommended_formation) { described_class.new(betting_number: 123) }

    it 'returns second element of betting_numbers' do
      expect(subject).to eq 2
    end
  end

  describe '#third' do
    subject { recommended_formation.third }

    let(:recommended_formation) { described_class.new(betting_number: 123) }

    it 'returns third element of betting_numbers' do
      expect(subject).to eq 3
    end
  end
end
