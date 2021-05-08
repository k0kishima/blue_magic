require 'rails_helper'

describe OfficialWebsite::CrawlBoatSettingsJob, type: :job do
  include_context 'with a mocked slack client'

  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/boat_settings' do
        described_class.perform_now(
          stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
          version: version
        )
      end
    end

    context 'when use version "1707"' do
      let(:version) { '1707' }
      let(:stadium_tel_code) { 4 }
      let(:race_opened_on) { Date.new(2021, 4, 24) }
      let(:race_number) { 1 }

      it 'saves boat settings' do
        expect { subject }.to change { BoatSetting.count }.by(6)
        expect(BoatSetting.all).to contain_exactly(
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 1,
            boat_number: 24,
            motor_number: 58,
            tilt: -0.5,
            propeller_renewed: false,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 2,
            boat_number: 54,
            motor_number: 47,
            tilt: -0.5,
            propeller_renewed: false,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 3,
            boat_number: 44,
            motor_number: 51,
            tilt: -0.5,
            propeller_renewed: false,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 4,
            boat_number: 62,
            motor_number: 52,
            tilt: 0.0,
            propeller_renewed: false,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 5,
            boat_number: 46,
            motor_number: 41,
            tilt: -0.5,
            propeller_renewed: false,
          ),
          have_attributes(
            stadium_tel_code: stadium_tel_code,
            date: race_opened_on,
            race_number: race_number,
            pit_number: 6,
            boat_number: 25,
            motor_number: 48,
            tilt: -0.5,
            propeller_renewed: false,
          ),
        )
      end

      it 'saves motor meintenances' do
        expect { subject }.to change { MotorMaintenance.count }.by(0)
      end
    end
  end
end
