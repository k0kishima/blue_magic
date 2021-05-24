require 'rails_helper'

describe Kpi::Factory, type: :model do
  describe '.create!' do
    subject { described_class.create!(hash) }

    context 'when a given hash has an item key' do
      context 'when a given hash has an attribute key' do
        context 'when a valid item specified' do
          describe 'create to stadium kpi' do
            let(:hash) { { item: item, attribute: attribute } }
            let(:item) { :stadium }

            context 'when a valid attribute specified' do
              let(:attribute) { :nige_succeed_rate_in_current_weather_condition }

              it 'creates a kpi' do
                subject.is_a?(Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition)
              end
            end

            context 'when a invalid attribute specified' do
              let(:attribute) { :something_invalid_attribute }

              it { expect { subject }.to raise_error(ArgumentError) }
            end
          end

          describe 'create to race entry kpi' do
            let(:hash) { { item: item, attribute: attribute } }
            let(:item) { :race_entries }

            context 'when a valid attribute specified' do
              let(:attribute) { :nige_succeed_rate_on_start_course_in_exhibition }

              context 'when a given hash has an modifier key' do
                let(:hash) { { item: item, attribute: attribute, modifier: modifier } }

                context 'when valid attribute spcified in the modifier key' do
                  let(:modifier) { [:pit_number, 1] }

                  it 'creates a kpi and assign the attribute' do
                    kpi = subject
                    kpi.is_a?(Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition)
                    expect(kpi.pit_number).to eq 1
                  end
                end

                context 'when invalid attribute spcified in the modifier key' do
                  let(:modifier) { [:racer_registration_number, 1] }

                  it { expect { subject }.to raise_error(NoMethodError) }
                end
              end

              context 'when a given hash does not have any modifier key' do
                it 'creates a kpi' do
                  subject.is_a?(Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition)
                end
              end
            end

            context 'when a invalid attribute specified' do
              let(:attribute) { :something_invalid_attribute }

              it { expect { subject }.to raise_error(ArgumentError) }
            end
          end
        end

        context 'when a invalid item specified' do
          let(:hash) { { item: :race_record, attribute: :something_attribute } }

          it { expect { subject }.to raise_error(ArgumentError) }
        end
      end

      context 'when a hash given which does not have attribute key' do
        let(:hash) { { item: :stadium } }

        it { expect { subject }.to raise_error(KeyError) }
      end
    end

    context 'when a hash given which does not have item key' do
      let(:hash) { {} }

      it { expect { subject }.to raise_error(KeyError) }
    end
  end

  describe '.create_recursively!' do
    subject { described_class.create_recursively!(hash) }

    let(:hash) do
      {
        and: [
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '<': [
              { item: :race_entries, modifier: [:pit_number, 1],
                attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.7 }
            ]
          },
        ]
      }
    end

    it 'creates kpis recursively from the hash' do
      kpis = subject
      expect(kpis.map(&:class)).to eq [Kpi::Race::SeriesGrade,
                                       Kpi::Race::IsSpecialRace,
                                       Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition]
      expect(kpis.map(&:attributes)).to eq [{ "source" => nil },
                                            { "source" => nil },
                                            { "source" => nil, "pit_number" => 1 }]
    end
  end
end
