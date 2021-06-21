require 'rails_helper'

describe RacerStartTimeKpi, type: :model do
  describe '#value!' do
    subject { kpi.value! }

    context 'in a kpi about current term' do
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

      describe 'average kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'start_time_average_in_current_rating_term') }

        before do
          kpi.entry_object = race_entry_4
        end

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

          it 'returns start time average in current term' do
            expect(subject).to eq 0.085
          end
        end

        context 'when race records not exist' do
          it { expect { subject }.to raise_error(DataNotFound) }
        end
      end

      describe 'sd kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'start_time_stdev_in_current_rating_term') }

        before do
          kpi.entry_object = race_entry_4
        end

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

          it 'returns start time stdev in current term' do
            expect(subject).to eq 0.021213203435596427
          end
        end

        context 'when race records not exist' do
          it { expect { subject }.to raise_error(DataNotFound) }
        end
      end
    end

    context 'in a kpi about current series' do
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

      describe 'average kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'start_time_average_in_current_series') }

        before do
          kpi.entry_object = race_entry_3
        end

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
            it { expect { subject }.to raise_error(DataNotFound) }
          end
        end

        context 'when event not exist' do
          it { expect { subject }.to raise_error(DataNotPrepared) }
        end
      end

      describe 'stdev kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'start_time_stdev_in_current_series') }

        before do
          kpi.entry_object = race_entry_3
        end

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
              expect(subject).to be_nan
            end
          end

          context 'when race records not exist' do
            it { expect { subject }.to raise_error(DataNotFound) }
          end
        end

        context 'when event not exist' do
          it { expect { subject }.to raise_error(DataNotPrepared) }
        end
      end
    end
  end
end
