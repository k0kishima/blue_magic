require 'rails_helper'

describe CancelRaceJob, type: :job do
  describe '#perform_now' do
    subject do
      described_class.perform_now(stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on,
                                  race_number: race_number,)
    end

    let(:stadium_tel_code) { 4 }
    let(:race_opened_on) { Date.new(2021, 4, 24) }
    let(:race_number) { 1 }

    context 'when the race exist' do
      let!(:race) { create(:race, stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number) }

      it 'makes race canceled' do
        expect { subject }.to change { race.reload.canceled }.to(true)
      end
    end

    context 'when the race does not exist' do
      it 'makes 2 attempts' do
        assert_performed_jobs 2 do
          subject rescue nil
        end
      end
    end
  end
end
