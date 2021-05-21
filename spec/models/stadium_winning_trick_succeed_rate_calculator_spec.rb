require 'rails_helper'

describe StadiumWinningTrickSucceedRateCalculator, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_presence_of(:trick) }
    it {
      is_expected.to validate_inclusion_of(:trick).in_array([
                                                              WinningTrick::Nige.instance,
                                                              WinningTrick::Sashi.instance,
                                                              WinningTrick::Makuri.instance,
                                                              WinningTrick::Makurizashi.instance,
                                                            ])
    }

    describe 'validate to course number' do
      subject { build(:stadium_winning_trick_succeed_rate_calculator, course_number: course_number, trick: trick) }

      let(:trick) { WinningTrick::Nige.instance }

      context 'when course number within avairable course numbers of the trick' do
        let(:course_number) { 1 }

        it { is_expected.to have(0).error_on(:course_number) }
      end

      context 'when course number not within avairable course numbers of the trick' do
        let(:course_number) { 2 }

        it { is_expected.to have(1).error_on(:course_number) }
      end
    end
  end

  describe '#calculate!' do
    subject { calculator.calculate!(aggregation_range: aggregation_range, context: context) }

    let(:calculator) {
      build(:stadium_winning_trick_succeed_rate_calculator, stadium_tel_code: stadium_tel_code,
                                                            course_number: course_number, trick: trick)
    }
    let(:stadium_tel_code) { 4 }
    let(:aggregation_starts_on) { Date.new(2020, 12, 1) }
    let(:aggregation_ends_on) { Date.new(2020, 12, 3) }
    let(:aggregation_range) { aggregation_starts_on..aggregation_ends_on }

    context 'when object is valid' do
      describe 'to calculate nige' do
        let(:trick) { WinningTrick::Nige.instance }
        let(:course_number) { 1 }

        before do
          # 集計期間外
          ## イン逃げ成功
          create(:race, :with_race_entries, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 1)
          create(:race_record, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 1,
                               pit_number: 1, course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 1,
                                      pit_number: 1, winning_trick: :nige,)

          create(:race, :with_race_entries, date: aggregation_ends_on.tomorrow, stadium_tel_code: 4, race_number: 1)
          create(:race_record, date: aggregation_ends_on.tomorrow, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on.tomorrow, stadium_tel_code: 4, race_number: 1,
                                      pit_number: 1, winning_trick: :nige,)

          # 集計期間内
          ## 指定された場
          ### イン逃げ成功
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1)
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                                      winning_trick: :nige,)

          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2)
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2, pit_number: 1,
                                      winning_trick: :nige,)

          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 1)
          create(:race_record, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                                      winning_trick: :nige,)

          ### イン逃げ失敗
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 3)
          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 2)

          ### 指定された場ではない
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 1)
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 1, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 1, pit_number: 1,
                                      winning_trick: :nige,)
        end

        context 'when a context not specified' do
          let(:context) { {} }

          it 'returns a trick succeed rate' do
            expect(subject).to eq Rational(3, 5)
          end
        end

        context 'when a context specified' do
          context 'when a velocity is not zero' do
            let(:context) { { wind_velocity: 1, wind_angle: 90 } }

            before do
              # イン逃げ成功・失敗したレース各々1Rずつ指定した水面気象状況に設定する
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                                         wind_velocity: 1, wind_angle: 90, in_performance: true)
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 3,
                                         wind_velocity: 1, wind_angle: 90, in_performance: true)

              # イン逃げ成功・失敗したレース各々1Rずつ指定した水面気象状況に設定するが展示なので集計対象外
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2,
                                         wind_velocity: 1, wind_angle: 90, in_performance: false)
              create(:weather_condition, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 2,
                                         wind_velocity: 1, wind_angle: 90, in_performance: false)

              # 集計対象外の水面気象状況
              create(:weather_condition, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 2,
                                         wind_velocity: 1, wind_angle: 180, in_performance: true)
            end

            it 'returns a trick succeed rate' do
              expect(subject).to eq Rational(1, 2)
            end
          end

          context 'when a velocity is zero' do
            let(:context) { { wind_velocity: 0, } }

            before do
              # イン逃げ成功・失敗したレース各々1Rずつ指定した水面気象状況に設定する
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                                         wind_velocity: 0, in_performance: true)
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 3,
                                         wind_velocity: 0, in_performance: true)

              # イン逃げ成功・失敗したレース各々1Rずつ指定した水面気象状況に設定するが展示なので集計対象外
              create(:weather_condition, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2,
                                         wind_velocity: 0, in_performance: false)
              create(:weather_condition, date: aggregation_ends_on, stadium_tel_code: 4, race_number: 2,
                                         wind_velocity: 0, in_performance: false)
            end

            it 'returns a trick succeed rate' do
              expect(subject).to eq Rational(1, 2)
            end
          end
        end
      end
    end

    context 'when object is invalid' do
      let(:trick) { WinningTrick::Nige.instance }

      context 'when an attribute is invalid' do
        let(:course_number) { 2 }
        let(:context) { nil }

        it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
      end

      context 'when a context argument is invalid' do
        let(:course_number) { 1 }

        context 'when a wind velocity specified' do
          context 'when a wind angle not specified' do
            let(:context) { { wind_velocity: 1, wind_angle: nil } }

            it { expect { subject }.to raise_error(ArgumentError) }
          end
        end

        context 'when a wind velocity not specified' do
          let(:context) { { wind_angle: nil } }

          it { expect { subject }.to raise_error(KeyError) }
        end
      end
    end
  end
end
