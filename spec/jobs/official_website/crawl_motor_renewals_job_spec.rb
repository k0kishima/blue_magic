require 'rails_helper'

describe OfficialWebsite::CrawlMotorRenewalsJob, type: :job do
  describe '#perform_now' do
    context 'when use version "1707"' do
      let(:version) { '1707' }

      context '中止になった節が存在しないとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/motor_renewals/20200316' do
            described_class.perform_now(date: date, version: version)
          end
        end

        let(:date) { Date.new(2020, 3, 16) }

        it 'saves motor renewals' do
          expect { subject }.to change { MotorRenewal.count }.by(1)
          expect(MotorRenewal.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: 19,
              date: date,
            ),
          )
        end
      end

      context '中止になった節が存在するとき' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/motor_renewals/20200808' do
            described_class.perform_now(date: date, version: version)
          end
        end

        let(:date) { Date.new(2020, 8, 8) }

        it 'saves motor renewals' do
          expect { subject }.not_to change { MotorRenewal.count }
        end
      end
    end
  end
end