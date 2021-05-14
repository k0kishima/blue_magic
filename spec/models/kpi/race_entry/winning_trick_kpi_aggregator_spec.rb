require 'rails_helper'

describe Kpi::RaceEntry::WinningTrickKpiAggregator, type: :model do
  let(:aggregator) {
    described_class.new(kpi: kpi, trick: trick, aggregation_range: aggregate_starts_on..aggregate_ends_on,
                        source: source)
  }

  describe '#aggregate' do
    subject { aggregator.aggregate }

    context 'when aggregate nige succeed rate' do
      let(:kpi) { Kpi::RaceEntry::NigeSucceedRate.instance }
      let(:trick) { WinningTrick::Nige.instance }

      let(:aggregate_starts_on) { Date.new(2020, 12, 1) }
      let(:aggregate_ends_on) { Date.new(2020, 12, 3) }
      let(:racer_1) { create(:racer, registration_number: 33333, last_name: '非集計対象者') }
      let(:racer_2) { create(:racer, registration_number: 77777, last_name: '集計対象者') }
      let(:source) { build(:race_entry, racer_registration_number: racer_2.registration_number) }

      before do
        # 集計期間内のレース
        create(:race, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8)
        create(:race, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 12)
        create(:race, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 6)
        create(:race, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 12)

        # 集計期間外のレース
        create(:race, date: aggregate_starts_on.yesterday, stadium_tel_code: 4, race_number: 12)
        create(:race, date: aggregate_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5)

        # 集計期間内の出走者
        ## 対象者
        create(:race_entry, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 4,
                            racer_registration_number: racer_2.registration_number)
        create(:race_entry, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                            racer_registration_number: racer_2.registration_number)
        create(:race_entry, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 5,
                            racer_registration_number: racer_2.registration_number)
        create(:race_entry, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 12, pit_number: 1,
                            racer_registration_number: racer_2.registration_number)
        ## 非対象者
        create(:race_entry, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 1,
                            racer_registration_number: racer_1.registration_number)
        create(:race_entry, date: aggregate_starts_on, stadium_tel_code: 5, race_number: 6, pit_number: 1,
                            racer_registration_number: racer_1.registration_number)

        # 集計期間外の出走者
        create(:race_entry, date: aggregate_starts_on.yesterday, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                            racer_registration_number: racer_2.registration_number)
        create(:race_entry, date: aggregate_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5, pit_number: 6,
                            racer_registration_number: racer_2.registration_number)

        # 集計期間内のレース結果
        ## 対象者
        ### ４枠から前付けしてイン強奪・そのまま逃げた想定（分子も分母も増える）
        create(:race_record, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 4,
                             course_number: 1, arrival: 1)
        create(:winning_race_entry, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8,
                                    pit_number: 4, winning_trick: :nige)
        ### 1コースには入ったがイン逃げ失敗（分母だけ増える）
        create(:race_record, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                             course_number: 1, arrival: 2)
        ### KPIと関係のないコース・着順(分子も分母も増えない)
        create(:race_record, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 6, pit_number: 5,
                             course_number: 5, arrival: 4)
        ### 枠なりで1コース進入・イン逃げ成功（分子も分母も増える）
        create(:race_record, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 12, pit_number: 1,
                             course_number: 1, arrival: 1)
        create(:winning_race_entry, date: aggregate_ends_on, stadium_tel_code: 5, race_number: 12,
                                    pit_number: 1, winning_trick: :nige,)

        ## 非対象者(分子も分母も増えない)
        ### 明らかに関係なし
        create(:race_record, date: aggregate_starts_on, stadium_tel_code: 4, race_number: 8, pit_number: 1,
                             course_number: 2, arrival: 2)
        ### イン逃げ成功
        create(:race_record, date: aggregate_starts_on, stadium_tel_code: 5, race_number: 6, pit_number: 1,
                             course_number: 1, arrival: 1)
        create(:winning_race_entry, date: aggregate_starts_on, stadium_tel_code: 5, race_number: 6,
                                    pit_number: 1, winning_trick: :nige,)

        # 集計期間外のレース結果(分子も分母も増えない)
        ### イン逃げ成功
        create(:race_record, date: aggregate_starts_on.yesterday, stadium_tel_code: 4, race_number: 12, pit_number: 1,
                             course_number: 1, arrival: 1)
        create(:winning_race_entry, date: aggregate_starts_on.yesterday, stadium_tel_code: 4, race_number: 12,
                                    pit_number: 1, winning_trick: :nige)
        ### 明らかに関係なし
        create(:race_record, date: aggregate_ends_on.tomorrow, stadium_tel_code: 5, race_number: 5, pit_number: 6,
                             course_number: 6, arrival: 6)
      end

      it 'returns kpi aggregation' do
        # 対象のレーサー以外含まれていないこと
        #   指定された決まり手のみ集計されること
        #   期間内のみ集計されること
        # 出走記録がない場合（例えば欠場など）は集計されないこと
        # 枠番じゃなくて本番の進入コース基準で集計されること
        expect(subject).to have_attributes(
          kpi: kpi,
          value: Rational(2, 3).to_f,
          aggregate_starts_on: aggregate_starts_on,
          aggregate_ends_on: aggregate_ends_on,
        )
      end
    end
  end
end
