require 'rails_helper'

describe Forecaster, type: :model do
  describe 'validations' do
    subject { forecaster }

    let(:forecaster) { create(:forecaster) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:betting_strategy) }
  end

  describe '#forecast!' do
    subject { forecaster.forecast!(race) }

    let(:forecaster) { create(:forecaster) }
    let(:other_forecaster) { create(:forecaster) }
    let(:forecasting_pattern_1) { create(:forecasting_pattern) }
    let(:forecasting_pattern_2) { create(:forecasting_pattern) }
    let(:forecasters_forecasting_pattern_1) do
      create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_1,)
    end
    let(:forecasters_forecasting_pattern_2) do
      create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_2,)
    end
    let(:race) { create(:race) }
    let(:recommend_odds_1) do
      create(:recommend_odds,
             forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_1.id,
             stadium_tel_code: race.stadium_tel_code,
             date: race.date,
             race_number: race.race_number,)
    end
    let(:recommend_odds_2) do
      create(:recommend_odds,
             forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_2.id,
             stadium_tel_code: race.stadium_tel_code,
             date: race.date,
             race_number: race.race_number,)
    end

    before do
      allow(forecaster).to receive(:forecasters_forecasting_patterns).and_return([forecasters_forecasting_pattern_1,
                                                                                  forecasters_forecasting_pattern_2])
    end

    context 'when recommend_odds do not exist yet' do
      before do
        allow(forecasters_forecasting_pattern_1).to receive(:create_recommend_odds_of!).with(race).and_return(
          [recommend_odds_1]
        )
        allow(forecasters_forecasting_pattern_2).to receive(:create_recommend_odds_of!).with(race).and_return(
          [recommend_odds_2]
        )
      end

      it 'creates and returns recommend odds' do
        expect(subject).to contain_exactly(recommend_odds_1, recommend_odds_2,)
      end
    end

    context 'when recommend_odds already exist' do
      before do
        allow(forecasters_forecasting_pattern_1).to \
          receive(:create_recommend_odds_of!).with(race).and_raise(ActiveRecord::RecordNotUnique)
      end

      it { expect { subject }.to raise_error(Forecaster::AlreadyForecasted) }
    end
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id               :bigint           not null, primary key
#  status           :integer          not null
#  name             :string(255)      not null
#  description      :text(65535)
#  betting_strategy :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
