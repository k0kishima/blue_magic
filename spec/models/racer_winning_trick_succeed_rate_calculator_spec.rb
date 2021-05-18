require 'rails_helper'

describe RacerWinningTrickSucceedRateCalculator, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:racer_registration_number) }
    it { is_expected.to validate_presence_of(:trick) }
    it { is_expected.to validate_presence_of(:course_number) }
    it {
      is_expected.to validate_inclusion_of(:trick).in_array([
                                                              WinningTrick::Nige.instance,
                                                              WinningTrick::Sashi.instance,
                                                              WinningTrick::Makuri.instance,
                                                              WinningTrick::Makurizashi.instance,
                                                            ])
    }

    describe 'validate to course number' do
      subject { build(:racer_winning_trick_succeed_rate_calculator, course_number: course_number, trick: trick) }

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
    subject { calculator.calculate!(aggregation_range: aggregation_range) }

    let(:calculator) {
      build(:racer_winning_trick_succeed_rate_calculator, racer_registration_number: racer_registration_number,
                                                          course_number: course_number, trick: trick)
    }
    let(:racer_registration_number) { 77_777 }
    let(:aggregation_starts_on) { Date.new(2020, 12, 1) }
    let(:aggregation_ends_on) { Date.new(2020, 12, 3) }
    let(:aggregation_range) { aggregation_starts_on..aggregation_ends_on }

    context 'when object is valid' do
      describe 'to calculate nige' do
        let(:trick) { WinningTrick::Nige.instance }
        let(:course_number) { 1 }
        let(:racer_1) { create(:racer, registration_number: 33_333, last_name: '非集計対象者') }
        let(:racer_2) { create(:racer, registration_number: 77_777, last_name: '集計対象者') }

        before do
          # 集計期間内のレース
          create(:race, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8)
          create(:race, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12)
          create(:race, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6)
          create(:race, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 12)

          # 集計期間外のレース
          create(:race, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 12)
          create(:race, date: aggregation_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5)

          # 集計期間内の出走者
          ## 対象者
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 4,
                              racer_registration_number: racer_2.registration_number)
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                              racer_registration_number: racer_2.registration_number)
          create(:race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 5,
                              racer_registration_number: racer_2.registration_number)
          create(:race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 12, pit_number: 1,
                              racer_registration_number: racer_2.registration_number)
          ## 非対象者
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 1,
                              racer_registration_number: racer_1.registration_number)
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 6, pit_number: 1,
                              racer_registration_number: racer_1.registration_number)

          # 集計期間外の出走者
          create(:race_entry, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                              racer_registration_number: racer_2.registration_number)
          create(:race_entry, date: aggregation_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5, pit_number: 6,
                              racer_registration_number: racer_2.registration_number)

          # 集計期間内のレース結果
          ## 対象者
          ### ４枠から前付けしてイン強奪・そのまま逃げた想定（分子も分母も増える）
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 4,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8,
                                      pit_number: 4, winning_trick: :nige)
          ### 1コースには入ったがイン逃げ失敗（分母だけ増える）
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                               course_number: 1, arrival: 2)
          ### KPIと関係のないコース・着順(分子も分母も増えない)
          create(:race_record, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 5,
                               course_number: 5, arrival: 4)
          ### 枠なりで1コース進入・イン逃げ成功（分子も分母も増える）
          create(:race_record, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 12, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 12,
                                      pit_number: 1, winning_trick: :nige,)

          ## 非対象者(分子も分母も増えない)
          ### 明らかに関係なし
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 1,
                               course_number: 2, arrival: 2)
          ### イン逃げ成功
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 6, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 5, race_number: 6,
                                      pit_number: 1, winning_trick: :nige,)

          # 集計期間外のレース結果(分子も分母も増えない)
          ### イン逃げ成功
          create(:race_record, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                               course_number: 1, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on.yesterday, stadium_tel_code: 4, race_number: 12,
                                      pit_number: 1, winning_trick: :nige)
          ### 明らかに関係なし
          create(:race_record, date: aggregation_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5, pit_number: 6,
                               course_number: 6, arrival: 6)
        end

        it 'returns a trick succeed rate' do
          expect(subject).to eq Rational(2, 3)
        end
      end

      describe 'to calculate sashi' do
        let(:trick) { WinningTrick::Sashi.instance }
        let(:course_number) { 2 }
        let(:racer_registration_number) { 77_777 }

        # 集計の範囲指定やレーサーIDの区別などは別のサンプルで検証できているので、
        # ここでは複数のコースで有効な決まり手において指定したコースでのみ集計されるかを検証する
        before do
          # 集計期間内のレース
          create(:race, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8)
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 2,
                              racer_registration_number: racer_registration_number)
          create(:race, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12)
          create(:race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 6,
                              racer_registration_number: racer_registration_number)
          create(:race, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6)
          create(:race_entry, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 6,
                              racer_registration_number: racer_registration_number)

          # 集計期間内のレース結果
          ## 対象者
          ### 指定されたコースで差し（分子も分母も増える）
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 2,
                               course_number: 2, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 8,
                                      pit_number: 2, winning_trick: :sashi)
          ### 指定されたコース以外で差し（分子も分母も増えない）
          create(:race_record, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 6,
                               course_number: 6, arrival: 1)
          create(:winning_race_entry, date: aggregation_starts_on, stadium_tel_code: 4, race_number: 12,
                                      pit_number: 6, winning_trick: :sashi)
          ### 指定されたコースで頭が取れなかった（分子のみ増える）
          create(:race_record, date: aggregation_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 6,
                               course_number: 2, arrival: 2)
        end

        it 'returns a trick succeed rate' do
          expect(subject).to eq Rational(1, 2)
        end
      end
    end

    context 'when object is invalid' do
      let(:trick) { WinningTrick::Nige.instance }
      let(:course_number) { 2 }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
