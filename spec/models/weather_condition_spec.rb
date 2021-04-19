require 'rails_helper'

RSpec.describe WeatherCondition, type: :model do
  let(:weather_condition) { create(:weather_condition) }

  describe 'association' do
    subject { weather_condition }

    it { is_expected.to belong_to(:race).optional }
  end

  describe 'validation' do
    subject { weather_condition }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to allow_value(true).for(:in_performance) }
    it { is_expected.to allow_value(false).for(:in_performance) }
    it { is_expected.not_to allow_value(nil).for(:in_performance) }
    it { is_expected.to validate_presence_of(:weather) }
    it { is_expected.to validate_presence_of(:wind_velocity) }
    it { is_expected.to validate_presence_of(:air_temperature) }
    it { is_expected.to validate_presence_of(:water_temperature) }
  end
end

# == Schema Information
#
# Table name: weather_conditions
#
#  air_temperature   :float(24)        not null
#  date              :date             not null, primary key
#  in_performance    :boolean          not null, primary key
#  race_number       :integer          not null, primary key
#  stadium_tel_code  :integer          not null, primary key
#  water_temperature :float(24)        not null
#  wavelength        :float(24)
#  weather           :integer          not null
#  wind_angle        :float(24)
#  wind_velocity     :float(24)        not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
