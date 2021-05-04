require 'rails_helper'

describe RacerRegistrationJob, type: :job do
  include_context 'with a mocked slack client'

  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/racer_profile' do
        described_class.perform_now(registration_number)
      end
    end

    let(:registration_number) { 4444 }

    context 'when the racer who has registration number which is spccified not exist yet' do
      context 'when the data of specified racer exist' do
        it 'register a racer' do
          expect { subject }.to change { Racer.count }.by(1)
          expect(Racer.all).to contain_exactly(
            have_attributes(
              registration_number: 4444,
              last_name: '桐生',
              first_name: '順平',
              gender: nil,
              term: 100,
              birth_date: Date.new(1986, 10, 7),
              branch_id: 11,
              birth_prefecture_id: 7,
              height: 161,
              status: 'active',
            )
          )
        end

        it 'invokes UpdateRacerGenderJob once' do
          expect { subject }.to have_enqueued_job(UpdateRacerGenderJob).once
        end
      end

      context 'when the data of specified racer not exist' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/racer_profiles/4559' do
            described_class.perform_now(registration_number)
          end
        end

        let(:registration_number) { 4559 }

        it 'register a racer by retire statesu' do
          expect { subject }.to change { Racer.count }.by(1)
          expect(Racer.all).to contain_exactly(
            have_attributes(
              registration_number: 4559,
              status: 'retired',
            )
          )
        end

        it 'invokes UpdateRacerGenderJob once' do
          expect { subject }.to have_enqueued_job(UpdateRacerGenderJob).once
        end
      end
    end

    context 'when the racer who has registration number which is spccified already exist' do
      let!(:racer) { create(:racer, registration_number: registration_number) }

      it 'does not create any racer' do
        expect { subject }.not_to change { Racer.count }
      end
    end
  end
end
