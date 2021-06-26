require 'rails_helper'

describe RaceEntry, type: :model do
  let(:race_entry) { create(:race_entry) }

  describe 'association' do
    subject { race_entry }

    it { is_expected.to belong_to(:stadium) }
    it { is_expected.to have_one(:racer_winning_rate_aggregation) }
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

  describe 'readers about order of arrival rate' do
    # rubocop:disable Layout/LineLength
    let(:other_racer) { Racer.create(registration_number: 33333, last_name: '舟田') }
    let(:target_racer) { Racer.create(registration_number: 77777, last_name: 'エースモーターマン') }
    let(:racer_registration_number) { target_racer.registration_number }
    let(:race) { create(:race, date: Date.new(2021, 1, 1)) }
    let(:race_entry) {
      create(:race_entry, **race.slice(*Race.primary_keys), racer_registration_number: racer_registration_number, pit_number: 1)
    }
    let(:start_exhibition_record) {
      create(:start_exhibition_record, **race.slice(*Race.primary_keys), pit_number: 1, course_number: 1)
    }
    let(:aggregate_starts_on) { Date.new(2020, 1, 1) }
    let(:aggregate_ends_on) { Date.new(2020, 12, 31) }
    let(:race_entry_of_out_of_the_range_race_1) { create(:race_entry, date: aggregate_starts_on.yesterday, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_out_of_the_range_race_2) { create(:race_entry, date: aggregate_ends_on.tomorrow, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_1) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_2) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_3) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 6) }
    let(:race_entry_of_in_the_range_race_4) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_5) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:other_race_entry_of_in_the_range_race_1) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: other_racer.registration_number, pit_number: 1) }
    # rubocop:enable Layout/LineLength

    describe '#first_place_rate_on_start_course_in_exhibition' do
      subject { race_entry.first_place_rate_on_start_course_in_exhibition }

      context 'when data prepared' do
        before do
          start_exhibition_record

          race_entry_of_out_of_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
          race_entry_of_out_of_the_range_race_2.create_race_record(course_number: 1, arrival: 1)
          race_entry_of_in_the_range_race_4.create_race_record(course_number: 2, arrival: 1)
          other_race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
        end

        context 'when race records of specified course within range exist' do
          before do
            race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
            race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 2)
            race_entry_of_in_the_range_race_3.create_race_record(course_number: 1, arrival: 1)
            race_entry_of_in_the_range_race_5.create_race_record(course_number: 1, arrival: 3)
          end

          it 'returns first place rate' do
            expect(subject).to eq Rational(2, 4)
          end
        end

        context 'when race records of specified course within range not exist' do
          it { expect { subject }.to raise_error(ZeroDivisionError) }
        end
      end

      context 'when data not prepared' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#second_place_rate_on_start_course_in_exhibition' do
      # 内部的に同じ集計ロジックを使用している `#first_place_rate_on_start_course_in_exhibition` で
      # 選択処理や例外発生ケースの検証すでにしているのでここでは命令網羅での検証しかしない
      subject { race_entry.second_place_rate_on_start_course_in_exhibition }

      before do
        start_exhibition_record

        race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
        race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 2)
      end

      it 'returns second place rate' do
        expect(subject).to eq Rational(1, 2)
      end
    end

    describe '#third_place_rate_on_start_course_in_exhibition' do
      subject { race_entry.third_place_rate_on_start_course_in_exhibition }

      before do
        start_exhibition_record

        race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 3)
        race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 3)
      end

      it 'returns third place rate' do
        expect(subject).to eq Rational(2, 2)
      end
    end

    describe '#quinella_rate_on_start_course_in_exhibition' do
      subject { race_entry.quinella_rate_on_start_course_in_exhibition }

      before do
        start_exhibition_record

        race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 2)
        race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 3)
        race_entry_of_in_the_range_race_3.create_race_record(course_number: 1, arrival: 1)
      end

      it 'returns quinella rate' do
        expect(subject).to eq Rational(2, 3)
      end
    end

    describe '#trio_rate_on_start_course_in_exhibition' do
      subject { race_entry.trio_rate_on_start_course_in_exhibition }

      before do
        start_exhibition_record

        race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 3)
        race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 4)
        race_entry_of_in_the_range_race_3.create_race_record(course_number: 1, arrival: 5)
      end

      it 'returns quinella rate' do
        expect(subject).to eq Rational(1, 3)
      end
    end
  end

  describe 'readers about start performance in current series' do
    let(:racer_registration_number) { 1 }
    let(:stadium_tel_code) { 4 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 23), stadium_tel_code: stadium_tel_code) }
    let(:race_2) { create(:race, date: Date.new(2021, 4, 30), stadium_tel_code: stadium_tel_code) }
    let(:race_3) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: stadium_tel_code) }
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }

    describe 'start_time_average_in_current_series' do
      subject { race_entry_3.start_time_average_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        context 'when race records exist' do
          before do
            # 集計対象外
            create(:race_record, race_entry: race_entry_1, start_time: 0.15)
            create(:race_record, race_entry: race_entry_3, start_time: 0.1)

            # 集計対象
            create(:race_record, race_entry: race_entry_2, start_time: 0.07)
          end

          it 'returns start time average in current term' do
            expect(subject).to eq 0.07
          end
        end

        context 'when race records not exist' do
          it { expect(subject).to be_nan }
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe 'start_time_stdev_in_current_series' do
      subject { race_entry_3.start_time_stdev_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        context 'when race records exist' do
          before do
            # 集計対象外
            create(:race_record, race_entry: race_entry_1, start_time: 0.15)
            create(:race_record, race_entry: race_entry_3, start_time: 0.1)

            # 集計対象
            create(:race_record, race_entry: race_entry_2, start_time: 0.07)
          end

          it 'returns start time stdev in current term' do
            # [29] pry(main)> [0.7].sd
            # => NaN
            expect(subject).to be_nan
          end
        end

        context 'when race records not exist' do
          # [29] pry(main)> [].sd
          # => 0.0
          it { expect(subject).to eq 0.0 }
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe 'start_order_average_in_current_series' do
      subject { race_entry_3.start_order_average_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        context 'when race records exist' do
          before do
            # 集計対象外
            create(:race_record, race_entry: race_entry_1, start_order: 1)
            create(:race_record, race_entry: race_entry_3, start_order: 3)

            # 集計対象
            create(:race_record, race_entry: race_entry_2, start_order: 2)
          end

          it 'returns start order average in current term' do
            expect(subject).to eq 2
          end
        end

        context 'when race records not exist' do
          it { expect(subject).to be_nan }
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe 'start_order_stdev_in_current_series' do
      subject { race_entry_3.start_order_stdev_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        context 'when race records exist' do
          before do
            # 集計対象外
            create(:race_record, race_entry: race_entry_1, start_order: 1)
            create(:race_record, race_entry: race_entry_3, start_order: 3)

            # 集計対象
            create(:race_record, race_entry: race_entry_2, start_order: 2)
          end

          it 'returns start order stdev in current term' do
            # [29] pry(main)> [2].sd
            # => NaN
            expect(subject).to be_nan
          end
        end

        context 'when race records not exist' do
          # [29] pry(main)> [].sd
          # => 0.0
          it { expect(subject).to eq 0.0 }
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end
  end

  describe 'readers about start performance in current rating term' do
    let(:target_racer_registration_number) { 1 }
    let(:other_racer_registration_number) { 2 }
    let(:race_1) {
      create(:race, date: Date.new(2021, 4, 30), betting_deadline_at: DateTime.new(2021, 4, 30, 9).in_time_zone)
    }
    let(:race_2) {
      create(:race, date: Date.new(2021, 5, 1), betting_deadline_at: DateTime.new(2021, 5, 1, 9).in_time_zone)
    }
    let(:race_3) {
      create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 9).in_time_zone)
    }
    let(:race_4) {
      create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 14).in_time_zone)
    }
    # rubocop:disable Layout/LineLength
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_4) {
      create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:other_race_entry) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: other_racer_registration_number)
    }
    # rubocop:enable Layout/LineLength

    describe 'start_time_average_in_current_rating_term' do
      subject { race_entry_4.start_time_average_in_current_rating_term }

      context 'when race records exist' do
        before do
          # 前期は集計対象外
          create(:race_record, race_entry: race_entry_1, start_time: 0.15)

          # 集計期間中
          ## 集計対象
          create(:race_record, race_entry: race_entry_2, start_time: 0.07)
          create(:race_record, race_entry: race_entry_3, start_time: 0.1)

          ## 対象レーサーではないので集計対象外
          create(:race_record, race_entry: other_race_entry, start_time: 0.15)

          ## 集計基準となるレースは集計対象外
          create(:race_record, race_entry: race_entry_4, start_time: 0.12)
        end

        it 'returns start time average in current rating term' do
          expect(subject).to eq 0.085
        end
      end

      context 'when race records not exist' do
        it { expect(subject).to be_nan }
      end
    end

    describe 'start_time_stdev_in_current_rating_term' do
      subject { race_entry_4.start_time_stdev_in_current_rating_term }

      context 'when race records exist' do
        before do
          # 前期は集計対象外
          create(:race_record, race_entry: race_entry_1, start_time: 0.15)

          # 集計期間中
          ## 集計対象
          create(:race_record, race_entry: race_entry_2, start_time: 0.07)
          create(:race_record, race_entry: race_entry_3, start_time: 0.1)

          ## 対象レーサーではないので集計対象外
          create(:race_record, race_entry: other_race_entry, start_time: 0.15)

          ## 集計基準となるレースは集計対象外
          create(:race_record, race_entry: race_entry_4, start_time: 0.12)
        end

        it 'returns start time stdev in current rating term' do
          expect(subject).to eq 0.021213203435596427
        end
      end

      context 'when race records not exist' do
        # [29] pry(main)> [].sd
        # => 0.0
        it { expect(subject).to eq 0.0 }
      end
    end

    describe 'start_order_average_in_current_rating_term' do
      subject { race_entry_4.start_order_average_in_current_rating_term }

      context 'when race records exist' do
        before do
          # 前期は集計対象外
          create(:race_record, race_entry: race_entry_1, start_order: 5)

          # 集計期間中
          ## 集計対象
          create(:race_record, race_entry: race_entry_2, start_order: 1)
          create(:race_record, race_entry: race_entry_3, start_order: 3)

          ## 対象レーサーではないので集計対象外
          create(:race_record, race_entry: other_race_entry, start_order: 1)

          ## 集計基準となるレースは集計対象外
          create(:race_record, race_entry: race_entry_4, start_order: 1)
        end

        it 'returns start order average in current rating term' do
          expect(subject).to eq 2
        end
      end

      context 'when race records not exist' do
        it { expect(subject).to be_nan }
      end
    end

    describe 'start_order_stdev_in_current_rating_term' do
      subject { race_entry_4.start_order_stdev_in_current_rating_term }

      context 'when race records exist' do
        before do
          # 前期は集計対象外
          create(:race_record, race_entry: race_entry_1, start_order: 5)

          # 集計期間中
          ## 集計対象
          create(:race_record, race_entry: race_entry_2, start_order: 1)
          create(:race_record, race_entry: race_entry_3, start_order: 3)

          ## 対象レーサーではないので集計対象外
          create(:race_record, race_entry: other_race_entry, start_order: 1)

          ## 集計基準となるレースは集計対象外
          create(:race_record, race_entry: race_entry_4, start_order: 1)
        end

        it 'returns start order stdev in current rating term' do
          expect(subject).to eq 1.4142135623730951
        end
      end

      context 'when race records not exist' do
        # [29] pry(main)> [].sd
        # => 0.0
        it { expect(subject).to eq 0.0 }
      end
    end
  end

  describe 'readers about order of arrivals in current series' do
    let(:racer_registration_number) { 1 }
    let(:stadium_tel_code) { 4 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 23), stadium_tel_code: stadium_tel_code) }
    let(:race_2) { create(:race, date: Date.new(2021, 4, 30), stadium_tel_code: stadium_tel_code) }
    let(:race_3) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: stadium_tel_code) }
    let(:race_4) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: stadium_tel_code) }
    let(:race_5) { create(:race, date: Date.new(2021, 5, 2), stadium_tel_code: stadium_tel_code) }
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_4) {
      create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_5) {
      create(:race_entry, **race_5.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }

    before do
      # 集計対象外
      create(:race_record, race_entry: race_entry_1)
      create(:race_record, race_entry: race_entry_5)

      # 集計対象
      create(:race_record, race_entry: race_entry_2, arrival: 1)
      create(:race_record, race_entry: race_entry_3, arrival: nil)
      create(:race_record, race_entry: race_entry_4, arrival: 3)
    end

    describe '#order_of_arrivals_in_current_series_without_unfinished' do
      subject { race_entry_5.order_of_arrivals_in_current_series_without_unfinished }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns collection of arrival orders' do
          expect(subject).to eq [1, 3]
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#finished_count_in_current_series' do
      subject { race_entry_5.finished_count_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns finished count in current series' do
          expect(subject).to eq 2
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#order_of_arrival_average_in_current_series' do
      subject { race_entry_5.order_of_arrival_average_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns average of order of arrivals in current series' do
          expect(subject).to eq 2.0
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#order_of_arrival_stdev_in_current_series' do
      subject { race_entry_5.order_of_arrival_stdev_in_current_series }

      context 'when event exist' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns stdev of order of arrivals in current series' do
          expect(subject).to eq 1.4142135623730951
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end
  end

  describe 'readers about disqualification in current series' do
    let(:racer_registration_number) { 1 }
    let(:stadium_tel_code) { 4 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 23), stadium_tel_code: stadium_tel_code) }
    let(:race_2) { create(:race, date: Date.new(2021, 4, 30), stadium_tel_code: stadium_tel_code) }
    let(:race_3) { create(:race, date: Date.new(2021, 5, 1), stadium_tel_code: stadium_tel_code) }
    let(:race_4) { create(:race, date: Date.new(2021, 5, 2), stadium_tel_code: stadium_tel_code) }
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }
    let(:race_entry_4) {
      create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: racer_registration_number)
    }

    before do
      create(:disqualified_race_entry, **race_1.slice(*Race.primary_keys), pit_number: race_entry_1.pit_number,
                                                                           disqualification: Disqualification::ID::VIOLATION)
      create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: race_entry_2.pit_number,
                                                                           disqualification: Disqualification::ID::FLYING)
      create(:disqualified_race_entry, **race_3.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number,
                                                                           disqualification: Disqualification::ID::LATENESS)
      create(:disqualified_race_entry, **race_4.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number,
                                                                           disqualification: Disqualification::ID::ABSENT)
    end

    describe '#disqualification_total_in_current_series' do
      subject { race_entry_4.disqualification_total_in_current_series }

      context 'when data prepared' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns disqualification total' do
          expect(subject).to eq 2
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#flying_count_in_current_series' do
      subject { race_entry_4.flying_count_in_current_series }

      context 'when data prepared' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns flying count' do
          expect(subject).to eq 1
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end

    describe '#lateness_count_in_current_series' do
      subject { race_entry_4.lateness_count_in_current_series }

      context 'when data prepared' do
        before do
          create(:event, starts_on: race_2.date, stadium_tel_code: race_2.stadium_tel_code)
        end

        it 'returns lateness count' do
          expect(subject).to eq 1
        end
      end

      context 'when event does not exist' do
        it { expect { subject }.to raise_error(DataNotPrepared) }
      end
    end
  end

  describe 'readers about disqualification in current racer rating term' do
    let(:target_racer_registration_number) { 1 }
    let(:other_racer_registration_number) { 2 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 30), betting_deadline_at: DateTime.new(2021, 4, 30, 9)) }
    let(:race_2) { create(:race, date: Date.new(2021, 5, 1), betting_deadline_at: DateTime.new(2021, 5, 1, 9)) }
    let(:race_3) { create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 9)) }
    let(:race_4) { create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 14)) }
    # rubocop:disable Layout/LineLength
    let(:race_entry_1) {
      create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_2) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_3) {
      create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:race_entry_4) {
      create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number)
    }
    let(:other_race_entry) {
      create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: other_racer_registration_number)
    }
    # rubocop:enable Layout/LineLength

    before do
      # rubocop:disable Layout/LineLength
      # 前期の失格は含まない
      create(:disqualified_race_entry, **race_1.slice(*Race.primary_keys), pit_number: race_entry_1.pit_number,
                                                                           disqualification: Disqualification::ID::FLYING)

      # 集計期間中
      ## 対象レーサーなので含む
      create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: race_entry_2.pit_number,
                                                                           disqualification: Disqualification::ID::LATENESS)
      create(:disqualified_race_entry, **race_3.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number,
                                                                           disqualification: Disqualification::ID::FLYING)
      ## 対象レーサーではないので含まない
      create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: other_race_entry.pit_number,
                                                                           disqualification: Disqualification::ID::FLYING)

      # 集計対象のレースでの失格は含まない
      create(:disqualified_race_entry, **race_4.slice(*Race.primary_keys), pit_number: race_entry_4.pit_number,
                                                                           disqualification: Disqualification::ID::FLYING)
      # rubocop:enable Layout/LineLength
    end

    describe '#disqualification_total_in_current_rating_term' do
      subject { race_entry_4.disqualification_total_in_current_rating_term }

      it 'returns disqualification total count' do
        expect(subject).to eq 2
      end
    end

    describe '#flying_count_in_current_rating_term' do
      subject { race_entry_4.flying_count_in_current_rating_term }

      it 'returns flying count' do
        expect(subject).to eq 1
      end
    end

    describe '#lateness_count_in_current_rating_term' do
      subject { race_entry_4.lateness_count_in_current_rating_term }

      it 'returns lateness count' do
        expect(subject).to eq 1
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
