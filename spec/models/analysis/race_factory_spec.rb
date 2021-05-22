require 'rails_helper'

describe Analysis::RaceFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(race, *kpis) }

    context 'when given race is not canceled' do
      let(:race) { create(:race, :with_race_entries) }
      let(:kpis) do
        [
          Kpi::Stadium::NigeSucceedRate.new,
          Kpi::Stadium::MakuriSucceedRate.new,
          Kpi::RaceEntry::NigeSucceedRate.new(pit_number: 1),
          Kpi::RaceEntry::NigashiRate.new(pit_number: 2),
        ]
      end

      before do
        allow_any_instance_of(Kpi::Stadium::NigeSucceedRate).to receive(:value!).and_return(56.7)
        allow_any_instance_of(Kpi::Stadium::MakuriSucceedRate).to receive(:value!).and_return(12.3)
        allow_any_instance_of(Kpi::RaceEntry::NigeSucceedRate).to receive(:value!).and_return(75.0)
        allow_any_instance_of(Kpi::RaceEntry::NigashiRate).to receive(:value!).and_return(60.0)
      end

      it 'returns an analysis race object' do
        object = subject
        expect(object).to have_attributes(**race.attributes.slice(*Race.primary_keys))
        expect(object.stadium).to have_attributes(
          nige_succeed_rate: 56.7,
          makuri_succeed_rate: 12.3,
        )
        expect(object.race_entries).to contain_exactly(
          have_attributes(
            pit_number: 1,
            nige_succeed_rate: 75.0,
          ),
          have_attributes(
            pit_number: 2,
            nigashi_rate: 60.0,
          ),
          have_attributes(
            pit_number: 3,
          ),
          have_attributes(
            pit_number: 4,
          ),
          have_attributes(
            pit_number: 5,
          ),
          have_attributes(
            pit_number: 6,
          ),
        )
      end
    end

    context 'when given race was canceled' do
      let(:race) { create(:race, :with_race_entries, canceled: true) }
      let(:kpis) { [] }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
