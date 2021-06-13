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

  describe '#event' do
    subject { race.event }

    let(:race) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: 4, race_number: 1) }

    context 'when event exist within a week from race opened date in specified stadium' do
      let(:event) { create(:event, starts_on: Date.new(2021, 4, 24), stadium_tel_code: 4) }

      before do
        create(:event, starts_on: Date.new(2021, 5, 1), stadium_tel_code: 3)
        create(:event, starts_on: Date.new(2021, 5, 2), stadium_tel_code: 4)
        event
      end

      it 'returns a event' do
        expect(subject).to eq event
      end
    end

    context 'when event does not exist within a week from race opened date in specified stadium' do
      before do
        create(:event, starts_on: Date.new(2021, 5, 1), stadium_tel_code: 3)
        create(:event, starts_on: Date.new(2021, 4, 23), stadium_tel_code: 4)
        create(:event, starts_on: Date.new(2021, 5, 2), stadium_tel_code: 4)
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#is_special_race' do
    subject { race.is_special_race }

    let(:race) { build(:race, title: title) }

    context 'when title is present' do
      context 'when title includes "特"' do
        let(:title) { '特賞' }

        it { is_expected.to be true }
      end

      context 'when title does not include "特"' do
        let(:title) { '予選' }

        it { is_expected.to be false }
      end
    end

    context 'when title is blank' do
      let(:title) { '' }

      it { is_expected.to be false }
    end
  end

  describe '#is_selection_race' do
    subject { race.is_selection_race }

    let(:race) { build(:race, title: title) }

    context 'when title is present' do
      context 'when title includes "選抜"' do
        let(:title) { '選抜' }

        it { is_expected.to be true }
      end

      context 'when title does not include "選抜"' do
        let(:title) { '予選' }

        it { is_expected.to be false }
      end
    end

    context 'when title is blank' do
      let(:title) { '' }

      it { is_expected.to be false }
    end
  end

  describe '#is_semifinal' do
    subject { race.is_semifinal }

    context 'when race number greater than or equal to 9' do
      let(:race) { build(:race, race_number: 9, title: '準優勝戦') }

      it { is_expected.to be true }
    end

    context 'when race number less than 9' do
      let(:race) { build(:race, race_number: 8, title: '準優進出戦') }

      it { is_expected.to be false }
    end
  end

  describe '#is_final' do
    subject { race.is_final }

    context 'when race number equal to 12' do
      let(:race) { build(:race, race_number: 12, title: '優勝戦') }

      it { is_expected.to be true }
    end

    context 'when race number less than 12' do
      let(:race) { build(:race, race_number: 11, title: '準優勝戦') }

      it { is_expected.to be false }
    end
  end

  describe 'ranking attribites' do
    context 'when a rankable attribute called' do
      subject { race.motor_quinella_rate_first }

      context 'when race entries are present' do
        let(:race) { create(:race, :with_race_entries) }

        context 'when race entry ranking attributes are present' do
          before do
            # hack: factory bot での cycle が同じ周期なので関連先まで作成できるが、暗黙的な規約を内包していてわかりにくいので明示的に作った方がいいかも
            # race.race_entries.each { |race_entry| create(:boat_setting, **race_entry.slice(*RaceEntry.primary_keys)) }
            create_list(:boat_setting, 6, **race.slice(*Race.primary_keys))
            create_list(:motor_betting_contribute_rate_aggregation, 6, stadium_tel_code: race.stadium_tel_code,
                                                                       aggregated_on: race.date)
          end

          it 'returns value of attribute of specified rank' do
            # TODO:
            # cycleが10刻みで設定してあるから6艇分のフィクスチャ作ったら60になる
            # けどこれだとわかりにくいから明示的に値指定して作るようにする
            expect(subject).to eq 60.0
          end
        end

        context 'when race entry ranking attributes are blank' do
          it { expect { subject }.to raise_error(Module::DelegationError) }
        end
      end

      context 'when race entries are blank' do
        let(:race) { create(:race) }

        it { expect { subject }.to raise_error(DataNotFound) }
      end
    end

    context 'when not a rankable attribute called' do
      let(:race) { create(:race) }

      subject { race.pit_number_first }

      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end
end

# == Schema Information
#
# Table name: races
#
#  stadium_tel_code    :integer          not null, primary key
#  date                :date             not null, primary key
#  race_number         :integer          not null, primary key
#  title               :string(255)      not null
#  course_fixed        :boolean          default(FALSE), not null
#  use_stabilizer      :boolean          default(FALSE), not null
#  number_of_laps      :integer          default(3), not null
#  betting_deadline_at :datetime         not null
#  canceled            :boolean          default(FALSE), not null
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
