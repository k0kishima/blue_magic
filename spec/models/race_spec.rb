require 'rails_helper'

RSpec.describe Race, type: :model do
  let(:race) { create(:race) }

  describe 'association' do
    subject { race }

    it { is_expected.to belong_to(:stadium) }
    it { is_expected.to have_many(:race_entries) }
    it { is_expected.to have_many(:weather_conditions) }
    it { is_expected.to have_many(:payoffs) }
    it { is_expected.to have_many(:odds) }
  end

  describe 'validation' do
    subject { race }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:number_of_laps) }
    it { is_expected.to validate_inclusion_of(:number_of_laps).in_range(2..3) }
    it { is_expected.to allow_value(true).for(:course_fixed) }
    it { is_expected.to allow_value(false).for(:course_fixed) }
    it { is_expected.not_to allow_value(nil).for(:course_fixed) }
    it { is_expected.to allow_value(true).for(:use_stabilizer) }
    it { is_expected.to allow_value(false).for(:use_stabilizer) }
    it { is_expected.not_to allow_value(nil).for(:use_stabilizer) }
    it { is_expected.to validate_presence_of(:betting_deadline_at) }

    describe 'betting_deadline_at' do
      let(:date) { Time.zone.today }
      let(:race) { Race.new(stadium_tel_code: 4, date: date, race_number: 1, betting_deadline_at: betting_deadline_at) }

      context 'when betting_deadline_at in date' do
        let(:betting_deadline_at) { date.in_time_zone.change(hour: 9) }

        it { is_expected.to have(0).error_on(:betting_deadline_at) }
      end

      context 'when betting_deadline_at not in date' do
        let(:betting_deadline_at) { date.yesterday.in_time_zone.change(hour: 9) }

        it { is_expected.to have(1).error_on(:betting_deadline_at) }
      end
    end
  end

  describe 'scopes' do
    describe 'wind condition scopes' do
      let(:race_1) { create(:race, date: Date.new(2021, 4, 6), stadium_tel_code: 3, race_number: 1) }
      let(:race_2) { create(:race, date: Date.new(2021, 4, 6), stadium_tel_code: 4, race_number: 6) }
      let(:race_3) { create(:race, date: Date.new(2021, 4, 6), stadium_tel_code: 5, race_number: 12) }
      let(:race_4) { create(:race, date: Date.new(2021, 4, 6), stadium_tel_code: 3, race_number: 6) }
      let(:weather_condition_1) {
        create(:weather_condition, race: race_1, wind_angle: 90, wind_velocity: 3, in_performance: true)
      }
      let(:weather_condition_2) {
        create(:weather_condition, race: race_2, wind_angle: 180, wind_velocity: 3, in_performance: false)
      }
      let(:weather_condition_3) {
        create(:weather_condition, race: race_3, wind_angle: 90, wind_velocity: 1, in_performance: true)
      }
      let(:weather_condition_4) {
        create(:weather_condition, race: race_4, wind_angle: 90, wind_velocity: 3, in_performance: false)
      }

      before do
        weather_condition_1
        weather_condition_2
        weather_condition_3
        weather_condition_4
      end

      describe '.by_wind_condition' do
        subject { described_class.by_wind_condition(wind_angle: wind_angle, wind_velocity: wind_velocity) }

        let(:wind_angle) { 90 }
        let(:wind_velocity) { 3 }

        it 'selects races by wind condition' do
          expect(subject).to contain_exactly(race_1, race_4)
        end
      end

      describe '.by_wind_condition_in_performance' do
        subject {
          described_class.by_wind_condition_in_performance(wind_angle: wind_angle, wind_velocity: wind_velocity)
        }

        let(:wind_angle) { 90 }
        let(:wind_velocity) { 3 }

        it 'selects races by wind condition' do
          expect(subject).to contain_exactly(race_1)
        end
      end

      describe '.by_wind_condition_in_exhibition' do
        subject {
          described_class.by_wind_condition_in_exhibition(wind_angle: wind_angle, wind_velocity: wind_velocity)
        }

        let(:wind_angle) { 90 }
        let(:wind_velocity) { 3 }

        it 'selects races by wind condition' do
          expect(subject).to contain_exactly(race_4)
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: races
#
#  betting_deadline_at :datetime         not null
#  canceled            :boolean          default(FALSE), not null
#  course_fixed        :boolean          default(FALSE), not null
#  date                :date             not null, primary key
#  number_of_laps      :integer          default(3), not null
#  race_number         :integer          not null, primary key
#  stadium_tel_code    :integer          not null, primary key
#  title               :string(255)      not null
#  use_stabilizer      :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_races_on_betting_deadline_at  (betting_deadline_at)
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
