require 'rails_helper'

describe OfficialWebsite::CrawlRaceInformationsJob, type: :job do
  describe '#perform_now' do
    context 'when use version "1707"' do
      let(:version) { '1707' }

      context 'レースが開催されているとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/race_informations/04_20210424_1R' do
            described_class.perform_now(
              stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
              version: version
            )
          end
        end

        let(:stadium_tel_code) { 4 }
        let(:race_opened_on) { Date.new(2021, 4, 24) }
        let(:race_number) { 1 }

        it 'saves races' do
          expect { subject }.to change { Race.count }.by(1)
          expect(Race.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              title: '予選',
              course_fixed: false,
              use_stabilizer: false,
              number_of_laps: 3,
              betting_deadline_at: race_opened_on.in_time_zone.change(hour: 11, min: 3),
              canceled: false,
            )
          )
        end

        it 'saves race entries' do
          expect { subject }.to change { RaceEntry.count }.by(6)
          expect(RaceEntry.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 5019,
              pit_number: 1,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 4945,
              pit_number: 2,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 3306,
              pit_number: 3,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 4496,
              pit_number: 4,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 4752,
              pit_number: 5,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              racer_registration_number: 4785,
              pit_number: 6,
            ),
          )
        end

        it 'saves boat_betting_contribute_rate_aggregations' do
          expect { subject }.to change { BoatBettingContributeRateAggregation.count }.by(6)
          expect(BoatBettingContributeRateAggregation.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 24,
              aggregated_on: race_opened_on,
              quinella_rate: 34.39,
              trio_rate: 54.14,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 25,
              aggregated_on: race_opened_on,
              quinella_rate: 33.13,
              trio_rate: 48.8,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 44,
              aggregated_on: race_opened_on,
              quinella_rate: 39.74,
              trio_rate: 57.69,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 46,
              aggregated_on: race_opened_on,
              quinella_rate: 27.88,
              trio_rate: 45.45,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 54,
              aggregated_on: race_opened_on,
              quinella_rate: 30.63,
              trio_rate: 45.63,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              boat_number: 62,
              aggregated_on: race_opened_on,
              quinella_rate: 38.64,
              trio_rate: 55.68,
            ),
          )
        end

        it 'saves motor_betting_contribute_rate_aggregations' do
          expect { subject }.to change { MotorBettingContributeRateAggregation.count }.by(6)
          expect(MotorBettingContributeRateAggregation.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 41,
              aggregated_on: race_opened_on,
              quinella_rate: 38.24,
              trio_rate: 57.06,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 47,
              aggregated_on: race_opened_on,
              quinella_rate: 32.52,
              trio_rate: 52.15,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 48,
              aggregated_on: race_opened_on,
              quinella_rate: 27.17,
              trio_rate: 42.2,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 51,
              aggregated_on: race_opened_on,
              quinella_rate: 37.95,
              trio_rate: 56.02,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 52,
              aggregated_on: race_opened_on,
              quinella_rate: 35.12,
              trio_rate: 51.79,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              motor_number: 58,
              aggregated_on: race_opened_on,
              quinella_rate: 35.71,
              trio_rate: 52.98,
            ),
          )
        end

        it 'saves racer_winning_rate_aggregations' do
          expect { subject }.to change { RacerWinningRateAggregation.count }.by(6)
          expect(RacerWinningRateAggregation.all).to contain_exactly(
            have_attributes(
              racer_registration_number: 3306,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 4.2,
              rate_in_event_going_stadium: 4.59,
            ),
            have_attributes(
              racer_registration_number: 4496,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 6.57,
              rate_in_event_going_stadium: 6.19,
            ),
            have_attributes(
              racer_registration_number: 4752,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 3.51,
              rate_in_event_going_stadium: 5.31,
            ),
            have_attributes(
              racer_registration_number: 4785,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 4.38,
              rate_in_event_going_stadium: 5.57,
            ),
            have_attributes(
              racer_registration_number: 4945,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 4.0,
              rate_in_event_going_stadium: 4.35,
            ),
            have_attributes(
              racer_registration_number: 5019,
              aggregated_on: race_opened_on,
              rate_in_all_stadium: 4.39,
              rate_in_event_going_stadium: 5.1,
            ),
          )
        end
      end

      context 'レースが開催されていないとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/race_informations/data_not_found' do
            described_class.perform_now(
              stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
              version: version
            )
          end
        end

        let(:stadium_tel_code) { 1 }
        let(:race_opened_on) { Date.new(2021, 4, 28) }
        let(:race_number) { 1 }

        it { expect { subject }.to raise_error(DataNotFound) }
        it { expect { subject rescue nil }.to_not change { Race.count } }
        it { expect { subject rescue nil }.to_not change { RaceEntry.count } }
        it { expect { subject rescue nil }.to_not change { BoatBettingContributeRateAggregation.count } }
        it { expect { subject rescue nil }.to_not change { MotorBettingContributeRateAggregation.count } }
        it { expect { subject rescue nil }.to_not change { RacerWinningRateAggregation.count } }
      end

      context 'proxyにアクセスできないとき' do
        include_context 'with an unavailable official website proxy'

        subject do
          described_class.perform_now(
            stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
            version: version
          )
        end

        let(:stadium_tel_code) { 1 }
        let(:race_opened_on) { Date.new(2021, 4, 28) }
        let(:race_number) { 1 }

        # TODO: 正式な処理を決める
        # proxyが落ちてるのは早めに感知したいのでslackでemergency系のチャンネルに通知飛ばすとかしたい
        # とはいえコーナーケースではあるため対応は保留し、一旦再現性を持たせたテストだけ作ってすぐ対応できるようにする
        it { expect { subject }.to raise_error(Errno::ECONNREFUSED) }
      end
    end
  end
end
