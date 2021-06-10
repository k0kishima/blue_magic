require 'rails_helper'

describe RaceEntry, type: :model do
  let(:race_entry) { create(:race_entry) }

  describe 'association' do
    subject { race_entry }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { race_entry }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:pit_number) }
    it { is_expected.to validate_inclusion_of(:pit_number).in_range(1..6) }
    it { is_expected.to validate_presence_of(:racer_registration_number) }
  end

  describe 'readers about motors' do
    describe '#motor_number' do
      subject { race_entry.motor_number }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), motor_number: 1)
        }

        before do
          boat_setting
        end

        it 'returns motor number' do
          expect(subject).to eq 1
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end

    describe '#motor_quinella_rate' do
      subject { race_entry.motor_quinella_rate }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), motor_number: 1)
        }

        before do
          boat_setting
        end

        context 'when motor_betting_contribute_rate_aggregation is present' do
          let(:motor_betting_contribute_rate_aggregation) {
            create(:motor_betting_contribute_rate_aggregation,
                   aggregated_on: race_entry.date,
                   stadium_tel_code: race_entry.stadium_tel_code,
                   motor_number: 1,
                   quinella_rate: 33.3)
          }

          before do
            motor_betting_contribute_rate_aggregation
          end

          it 'returns motor number' do
            expect(subject).to eq 33.3
          end
        end

        context 'when motor_betting_contribute_rate_aggregation is blank' do
          it { expect { subject }.to raise_error(NoMethodError) }
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end

    describe '#motor_trio_rate' do
      subject { race_entry.motor_trio_rate }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), motor_number: 1)
        }

        before do
          boat_setting
        end

        context 'when motor_betting_contribute_rate_aggregation is present' do
          let(:motor_betting_contribute_rate_aggregation) {
            create(:motor_betting_contribute_rate_aggregation,
                   aggregated_on: race_entry.date,
                   stadium_tel_code: race_entry.stadium_tel_code,
                   motor_number: 1,
                   trio_rate: 33.3)
          }

          before do
            motor_betting_contribute_rate_aggregation
          end

          it 'returns motor number' do
            expect(subject).to eq 33.3
          end
        end

        context 'when motor_betting_contribute_rate_aggregation is blank' do
          it { expect { subject }.to raise_error(NoMethodError) }
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end
  end

  describe 'readers about boats' do
    describe '#boat_number' do
      subject { race_entry.boat_number }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), boat_number: 1)
        }

        before do
          boat_setting
        end

        it 'returns boat number' do
          expect(subject).to eq 1
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end

    describe '#boat_quinella_rate' do
      subject { race_entry.boat_quinella_rate }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), boat_number: 1)
        }

        before do
          boat_setting
        end

        context 'when boat_betting_contribute_rate_aggregation is present' do
          let(:boat_betting_contribute_rate_aggregation) {
            create(:boat_betting_contribute_rate_aggregation,
                   aggregated_on: race_entry.date,
                   stadium_tel_code: race_entry.stadium_tel_code,
                   boat_number: 1,
                   quinella_rate: 33.3)
          }

          before do
            boat_betting_contribute_rate_aggregation
          end

          it 'returns boat number' do
            expect(subject).to eq 33.3
          end
        end

        context 'when boat_betting_contribute_rate_aggregation is blank' do
          it { expect { subject }.to raise_error(NoMethodError) }
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end

    describe '#boat_trio_rate' do
      subject { race_entry.boat_trio_rate }

      context 'when boat setting is present' do
        let(:boat_setting) {
          create(:boat_setting, **race_entry.attributes.slice(*RaceEntry.primary_keys), boat_number: 1)
        }

        before do
          boat_setting
        end

        context 'when boat_betting_contribute_rate_aggregation is present' do
          let(:boat_betting_contribute_rate_aggregation) {
            create(:boat_betting_contribute_rate_aggregation,
                   aggregated_on: race_entry.date,
                   stadium_tel_code: race_entry.stadium_tel_code,
                   boat_number: 1,
                   trio_rate: 33.3)
          }

          before do
            boat_betting_contribute_rate_aggregation
          end

          it 'returns boat number' do
            expect(subject).to eq 33.3
          end
        end

        context 'when boat_betting_contribute_rate_aggregation is blank' do
          it { expect { subject }.to raise_error(NoMethodError) }
        end
      end

      context 'when boat setting is blank' do
        it { expect { subject }.to raise_error(Module::DelegationError) }
      end
    end
  end
end

# == Schema Information
#
# Table name: race_entries
#
#  stadium_tel_code          :integer          not null, primary key
#  date                      :date             not null, primary key
#  race_number               :integer          not null, primary key
#  racer_registration_number :integer          not null
#  pit_number                :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,racer_registration_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
