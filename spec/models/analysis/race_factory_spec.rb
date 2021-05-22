require 'rails_helper'

describe Analysis::RaceFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(race, *kpis) }

    context 'when given race is not canceled' do
      let(:race) { create(:race, :with_race_entries) }
      let(:kpis) do
        [
          Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition.new,
          Kpi::Stadium::MakuriSucceedRateInCurrentWeatherCondition.new,
          Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition.new(pit_number: 1),
          Kpi::RaceEntry::NigashiRateOnStartCourseInExhibition.new(pit_number: 2),
        ]
      end

      before do
        allow_any_instance_of(Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition).to receive(:value!).and_return(56.7)
        allow_any_instance_of(Kpi::Stadium::MakuriSucceedRateInCurrentWeatherCondition).to receive(:value!).and_return(12.3)
        allow_any_instance_of(Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition).to receive(:value!).and_return(75.0)
        allow_any_instance_of(Kpi::RaceEntry::NigashiRateOnStartCourseInExhibition).to receive(:value!).and_return(60.0)
      end

      it 'returns an analysis race object' do
        object = subject
        expect(object).to have_attributes(**race.attributes.slice(*Race.primary_keys))
        expect(object.stadium).to have_attributes(
          nige_succeed_rate_in_current_weather_condition: 56.7,
          makuri_succeed_rate_in_current_weather_condition: 12.3,
        )
        expect(object.race_entries).to contain_exactly(
          have_attributes(
            pit_number: 1,
            nige_succeed_rate_on_start_course_in_exhibition: 75.0,
          ),
          have_attributes(
            pit_number: 2,
            nigashi_rate_on_start_course_in_exhibition: 60.0,
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
