require 'rails_helper'

describe OfficialWebsite::CrawlRaceResultsJob, type: :job do
  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/race_result' do
        described_class.perform_now(
          stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
          version: version
        )
      end
    end

    # TODO: レース中止のコンテキストを追加
    before do
      ActiveJob::Base.queue_adapter = :test
    end

    context 'when use version "1707"' do
      let(:version) { '1707' }
      let(:stadium_tel_code) { 4 }
      let(:race_opened_on) { Date.new(2021, 4, 24) }
      let(:race_number) { 1 }

      it 'saves weather conditions' do
        expect { subject }.to change { WeatherCondition.count }.by(1)
        expect(WeatherCondition.all).to contain_exactly(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            in_performance: true,
            weather: 'cloudy',
            wind_velocity: 2.0,
            wind_angle: 45.0,
            wavelength: 3.0,
            air_temperature: 17.0,
            water_temperature: 17.0,
          )
        )
      end

      it 'saves race records' do
        expect { subject }.to change { RaceRecord.count }.by(6)
        expect(RaceRecord.all).to contain_exactly(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 1,
            course_number: 1,
            start_time: 0.24,
            start_order: 3,
            race_time: 110.1,
            arrival: 1,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 2,
            course_number: 2,
            start_time: 0.21,
            start_order: 1,
            race_time: nil,
            arrival: 5,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            course_number: 3,
            start_time: 0.25,
            start_order: 4,
            race_time: nil,
            arrival: 6,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            course_number: 4,
            start_time: 0.22,
            start_order: 2,
            race_time: 112.7,
            arrival: 2,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 5,
            course_number: 5,
            start_time: 0.25,
            start_order: 4,
            race_time: 115.9,
            arrival: 4,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 6,
            course_number: 6,
            start_time: 0.3,
            start_order: 6,
            race_time: 114.0,
            arrival: 3,
          ),
        )
      end

      it 'saves disqualified_race_entries' do
        expect { subject }.to change { DisqualifiedRaceEntry.count }.by(0)
      end

      it 'saves winning_race_entries' do
        expect { subject }.to change { WinningRaceEntry.count }.by(1)
        expect(WinningRaceEntry.all).to contain_exactly(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 1,
            winning_trick: 'nige',
          ),
        )
      end

      it 'saves payoffs' do
        expect { subject }.to change { Payoff.count }.by(1)
        expect(Payoff.all).to contain_exactly(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            betting_method: 'trifecta',
            betting_number: 146,
            amount: 4960,
          ),
        )
      end
    end
  end
end
