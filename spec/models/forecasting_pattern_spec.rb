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

  describe '#match?' do
    subject { forecasting_pattern.match?(race) }

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
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.5 }
            ]
          },
        ]
      }
    end
    let(:race) { create(:race, title: '一般戦') }

    context 'when the race is matched the filtering condition' do
      before do
        allow_any_instance_of(StadiumWinningTrickKpi).to receive(:value!).and_return(0.51)
      end

      it { is_expected.to be true }
    end

    context 'when the race is not matched the filtering condition' do
      before do
        allow_any_instance_of(StadiumWinningTrickKpi).to receive(:value!).and_return(0.50)
      end

      it { is_expected.to be false }
    end
  end

  describe '#recommended_formation' do
    subject { forecasting_pattern.recommended_formation(race) }

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

      it 'returns a formation' do
        expect(subject.betting_numbers).to eq []
      end
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
