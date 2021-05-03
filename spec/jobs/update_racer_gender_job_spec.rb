require 'rails_helper'

describe UpdateRacerGenderJob, type: :job do
  describe '#perform_now' do
    subject { described_class.perform_now(racer.registration_number) }

    let(:racer) { create(:racer, registration_number: 4444, gender: gender) }

    shared_examples :be_discarded do
      it 'does not perform job' do
        assert_no_performed_jobs do
          subject
        end
      end
    end

    context 'when the racer exist' do
      context 'when the racer gender already had not been recorded' do
        let(:gender) { nil }

        context 'when the race exist' do
          let!(:race) {
            create(:race, :with_race_entries, date: Date.new(2021, 5, 4), stadium_tel_code: 2, race_number: 12)
          }

          before do
            race.race_entries.first.update!(racer_registration_number: racer.registration_number)
          end

          context 'when the event exist' do
            subject do
              VCR.use_cassette 'official_web_site_proxy/v1707/event_entries/02_20210501' do
                described_class.perform_now(racer.registration_number)
              end
            end

            let!(:event) { create(:event, starts_on: Date.new(2021, 5, 1), stadium_tel_code: 2) }

            it 'updates gender of the racer' do
              expect { subject }.to change { racer.reload.gender }.to('male')
            end
          end

          context 'when the event does not exist' do
            it_behaves_like :be_discarded
          end
        end

        context 'when the race does not exist' do
          it_behaves_like :be_discarded
        end
      end

      context 'when the racer gender already had been recorded' do
        let(:gender) { :male }

        it 'returns false' do
          expect(subject).to eq false
        end
      end
    end

    context 'when the racer does not exist' do
      let(:gender) { nil }

      it_behaves_like :be_discarded
    end
  end
end
