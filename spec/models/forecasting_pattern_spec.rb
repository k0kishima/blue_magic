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
