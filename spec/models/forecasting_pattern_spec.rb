require 'rails_helper'

describe ForecastingPattern, type: :model do
  describe 'validations' do
    subject { forecasting_pattern }
    let(:forecasting_pattern) { create(:forecasting_pattern) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:race_filtering_condition) }
    it { is_expected.to validate_presence_of(:first_place_filtering_condition) }
    it { is_expected.to validate_presence_of(:second_place_filtering_condition) }
    it { is_expected.to validate_presence_of(:third_place_filtering_condition) }
    it { is_expected.to validate_presence_of(:odds_filtering_condition) }
  end

  describe '#forecastable?' do
    subject { forecasting_pattern.forecastable?(race) }

    let(:forecasting_pattern) { create(:forecasting_pattern, race_filtering_condition: race_filtering_condition) }
    let(:race_filtering_condition) do
      {
        and: [
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '>': [
              { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
        ]
      }
    end
    let(:race) { create(:race, :with_race_entries, title: '一般戦') }

    context 'when the race is matched the filtering condition' do
      before do
        allow_any_instance_of(RacerWinningTrickKpi).to receive(:value!).and_return(0.51)
      end

      it { is_expected.to be true }
    end

    context 'when the race is not matched the filtering condition' do
      before do
        allow_any_instance_of(RacerWinningTrickKpi).to receive(:value!).and_return(0.50)
      end

      it { is_expected.to be false }
    end
  end

  describe '#recommended_formation_of' do
    subject { forecasting_pattern.recommended_formation_of(race) }

    let(:forecasting_pattern) do
      create(
        :forecasting_pattern,
        first_place_filtering_condition: first_place_filtering_condition,
        second_place_filtering_condition: second_place_filtering_condition,
        third_place_filtering_condition: third_place_filtering_condition
      )
    end
    let(:first_place_filtering_condition) do
      {
        and: [
          {
            '==': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '>': [
              { item: :itself, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.6 }
            ]
          },
        ]
      }
    end
    let(:second_place_filtering_condition) do
      {
        and: [
          {
            '<=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 3 }
            ]
          },
        ]
      }
    end
    let(:third_place_filtering_condition) do
      {
        and: [
          {
            '<=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 4 }
            ]
          },
        ]
      }
    end
    let(:race) { create(:race, :with_race_entries) }

    before do
      create_list(:start_exhibition_record, 6, date: race.date, stadium_tel_code: race.stadium_tel_code,
                                               race_number: race.race_number)
    end

    context 'when the race is forecastable' do
      before do
        allow(forecasting_pattern).to receive(:forecastable?).and_return(true)
      end

      context 'when race entries matched in all place' do
        before do
          allow_any_instance_of(RacerWinningTrickKpi).to receive(:value!).and_return(0.61)
        end

        it 'returns a formation' do
          expect(subject.betting_numbers).to eq [123, 124, 132, 134]
        end
      end

      context 'when any race entries not matched' do
        before do
          allow_any_instance_of(RacerWinningTrickKpi).to receive(:value!).and_return(0.60)
        end

        it 'returns a blank formation' do
          expect(subject.betting_numbers).to eq []
        end
      end
    end

    context 'when the race is not forecastable' do
      before do
        allow(forecasting_pattern).to receive(:forecastable?).and_return(false)
      end

      it 'returns a blank formation' do
        expect(subject.betting_numbers).to eq []
      end
    end
  end

  describe '#recommend_odds_of' do
    subject { forecasting_pattern.recommend_odds_of(race) }

    let(:race) { create(:race) }
    let(:forecasting_pattern) { create(:forecasting_pattern, odds_filtering_condition: odds_filtering_condition) }
    let(:odds_filtering_condition) do
      {
        and: [
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 20 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          }
        ]
      }
    end

    context 'when the race has odds' do
      context 'when the race is forecastable' do
        before do
          allow(forecasting_pattern).to receive(:forecastable?).and_return(true)
        end

        context 'when race entries are matched' do
          before do
            # [123, 124, 132, 134]
            allow(forecasting_pattern).to receive(:recommended_formation_of).and_return(Formation.new([[1], [2, 3],
                                                                                                       [2, 3, 4]]))
          end

          context 'when matched odds is present' do
            let(:odds1_which_is_expect_to_match) { create(:odds, race: race, betting_number: 123, ratio: 20) }
            let(:odds2_which_is_expect_to_match) { create(:odds, race: race, betting_number: 132, ratio: 100) }

            before do
              odds1_which_is_expect_to_match
              odds2_which_is_expect_to_match
              create(:odds, race: race, betting_number: 213, ratio: 20)
              create(:odds, race: race, betting_number: 134, ratio: 100.1)
            end

            it 'returns odds array which was matched the condition' do
              expect(subject).to eq [odds1_which_is_expect_to_match, odds2_which_is_expect_to_match]
            end
          end

          context 'when matched odds is not present' do
            before do
              create(:odds, race: race, betting_number: 123, ratio: 19.9)
            end

            it 'returns a blank array' do
              expect(subject).to eq []
            end
          end
        end

        context 'when race entries are not matched' do
          before do
            create(:odds, race: race, betting_number: 213, ratio: 20)
            allow(forecasting_pattern).to receive(:recommended_formation_of).and_return(Formation.new([[], [], []]))
          end

          it 'returns a blank array' do
            expect(subject).to eq []
          end
        end
      end

      context 'when the race is not forecastable' do
        before do
          create(:odds, race: race, betting_number: 213, ratio: 20)
          allow(forecasting_pattern).to receive(:forecastable?).and_return(false)
        end

        it 'returns a blank array' do
          expect(subject).to eq []
        end
      end
    end

    context 'when the race does not have odds' do
      it { expect { subject }.to raise_error(DataNotPrepared) }
    end
  end
end

# == Schema Information
#
# Table name: forecasting_patterns
#
#  id                               :bigint           not null, primary key
#  name                             :string(255)      not null
#  description                      :text(65535)
#  race_filtering_condition         :json             not null
#  first_place_filtering_condition  :json             not null
#  second_place_filtering_condition :json             not null
#  third_place_filtering_condition  :json             not null
#  odds_filtering_condition         :json             not null
#  frozen_at                        :datetime
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
