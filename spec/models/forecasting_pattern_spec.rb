require 'rails_helper'

describe ForecastingPattern, type: :model do
  let(:forecasting_pattern) { create(:forecasting_pattern) }

  describe 'validations' do
    subject { forecasting_pattern }

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
            '>': [
              { item: :stadium, attribute: :nige_succeed_rate_in_current_weather_condition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '>': [
              { item: :race_entries, modifier: [:pit_number, 1],
                attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.7 }
            ]
          }
        ]
      }
    end
    let(:race) { create(:race, :with_race_entries) }

    context 'when the race is matched the filtering condition' do
      before do
        allow_any_instance_of(Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition).to receive(:value!).and_return(0.51)
        allow_any_instance_of(Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition).to receive(:value!).and_return(0.71)
      end

      it { is_expected.to be true }
    end

    context 'when the race is not matched the filtering condition' do
      before do
        allow_any_instance_of(Kpi::Stadium::NigeSucceedRateInCurrentWeatherCondition).to receive(:value!).and_return(0.51)
        allow_any_instance_of(Kpi::RaceEntry::NigeSucceedRateOnStartCourseInExhibition).to receive(:value!).and_return(0.7)
      end

      it { is_expected.to be false }
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
