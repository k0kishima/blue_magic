require 'rails_helper'

describe RacerAssistTrickSucceedRateCalculator, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:racer_registration_number) }
    it { is_expected.to validate_presence_of(:trick) }
    it { is_expected.to validate_presence_of(:course_number) }
    it {
      is_expected.to validate_inclusion_of(:trick).in_array([
                                                              AssistTrick::Nigashi.instance,
                                                              AssistTrick::Sasare.instance,
                                                              AssistTrick::Makurare.instance,
                                                            ])
    }

    describe 'validate to course number' do
      subject { build(:racer_assist_trick_succeed_rate_calculator, course_number: course_number, trick: trick) }

      let(:trick) { AssistTrick::Nigashi.instance }

      context 'when course number within avairable course numbers of the trick' do
        let(:course_number) { 2 }

        it { is_expected.to have(0).error_on(:course_number) }
      end

      context 'when course number not within avairable course numbers of the trick' do
        let(:course_number) { 1 }

        it { is_expected.to have(1).error_on(:course_number) }
      end
    end
  end

  describe '#calculate!' do
    subject { calculator.calculate!(aggregation_range: aggregation_range) }

    let(:calculator) {
      build(:racer_assist_trick_succeed_rate_calculator, racer_registration_number: racer_registration_number,
                                                         course_number: course_number, trick: trick)
    }
    let(:racer_registration_number) { 77_777 }
    let(:aggregation_starts_on) { Date.new(2020, 12, 1) }
    let(:aggregation_ends_on) { Date.new(2020, 12, 3) }
    let(:aggregation_range) { aggregation_starts_on..aggregation_ends_on }

    context 'when object is valid' do
      describe 'to calculate nigashi rate' do
        let(:trick) { AssistTrick::Nigashi.instance }
        let(:course_number) { 2 }

        before do
          # 集計期間内のレース
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1)
          create_list(:race_record, 6, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1)
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2)
          create_list(:race_record, 6, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2)
          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1)
          create_list(:race_record, 6, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1)
          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2)
          create_list(:race_record, 6, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2)

          ## イン逃げ成功したレース
          RaceRecord.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                             pit_number: 1).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1, pit_number: 1,
                                      winning_trick: :nige)
          RaceRecord.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2,
                             pit_number: 1).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2, pit_number: 1,
                                      winning_trick: :nige)
          RaceRecord.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1,
                             pit_number: 1).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1, pit_number: 1,
                                      winning_trick: :nige)

          ## イン逃げ失敗したレース
          RaceRecord.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2,
                             pit_number: 2).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2, pit_number: 2,
                                      winning_trick: :sashi)

          # 集計対象者がイン逃げ成功したレースで2コース進入（分子も分母も増える）
          RaceEntry.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                            pit_number: 2).update!(racer_registration_number: racer_registration_number)

          # 集計対象者がイン逃げ成功したレースで3コース進入（分子も分母も増えない）
          RaceEntry.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1,
                            pit_number: 3).update!(racer_registration_number: racer_registration_number)

          # 集計対象者がイン逃げ失敗したレースで2コース（分母のみ増える）
          RaceEntry.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2,
                            pit_number: 2).update!(racer_registration_number: racer_registration_number)

          # 集計期間外のレース
          create(:race, :with_race_entries, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 1)
          create(:race, :with_race_entries, date: aggregation_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5)
        end

        it 'returns a trick succeed rate' do
          expect(subject).to eq Rational(1, 2).to_f
        end
      end

      describe 'to calculate sasare rate' do
        let(:trick) { AssistTrick::Sasare.instance }
        let(:course_number) { 1 }

        before do
          # 集計期間内のレース
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1)
          create_list(:race_record, 6, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1)
          create(:race, :with_race_entries, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2)
          create_list(:race_record, 6, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2)
          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1)
          create_list(:race_record, 6, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1)
          create(:race, :with_race_entries, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2)
          create_list(:race_record, 6, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2)

          ## 決まり手が差しのレース
          RaceRecord.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                             pit_number: 2).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1, pit_number: 2,
                                      winning_trick: :sashi)
          RaceRecord.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2,
                             pit_number: 2).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2, pit_number: 2,
                                      winning_trick: :sashi)
          ## 決まり手がまくり差しのレース
          RaceRecord.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1,
                             pit_number: 3).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1, pit_number: 3,
                                      winning_trick: :makurizashi)
          ## 決まり手が逃げのレース
          RaceRecord.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2,
                             pit_number: 1).update!(arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2, pit_number: 1,
                                      winning_trick: :nige)

          # 集計対象者が差しで決まったレースで1コース進入（分子も分母も増える）
          RaceEntry.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 1,
                            pit_number: 1).update!(racer_registration_number: racer_registration_number)

          # 集計対象者が差しで決まったレースで1コース以外で進入（分子も分母も増えない）
          RaceEntry.find_by(date: aggregation_starts_on, stadium_tel_code: 4, race_number: 2,
                            pit_number: 3).update!(racer_registration_number: racer_registration_number)

          # 集計対象者がまくり差しで決まったレースで1コース進入（分子も分母も増える）
          RaceEntry.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 1,
                            pit_number: 1).update!(racer_registration_number: racer_registration_number)

          # 集計対象者がイン逃げ成功（分母のみ増える）
          RaceEntry.find_by(date: aggregation_ends_on, stadium_tel_code: 5, race_number: 2,
                            pit_number: 1).update!(racer_registration_number: racer_registration_number)
        end

        it 'returns a trick succeed rate' do
          expect(subject).to eq Rational(2, 3).to_f
        end
      end
    end

    context 'when object is invalid' do
      let(:trick) { AssistTrick::Nigashi.instance }
      let(:course_number) { 1 }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
