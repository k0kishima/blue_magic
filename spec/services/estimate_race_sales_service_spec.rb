require 'rails_helper'

RSpec.describe EstimateRaceSalesService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  describe '.call' do
    subject { described_class.call(betting_deadline_at: betting_deadline_at) }

    context 'on a weekday' do
      before do
        travel_to Time.zone.local(2021, 5, 7)  # ※ 金曜日
      end

      context 'in the morning' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 8) }

        it { is_expected.to eq 4_000_000 }
      end

      context 'in the noon' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 13) }

        it { is_expected.to eq 4_800_000 }
      end

      context 'in the nighter race' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 18) }

        it { is_expected.to eq 6_000_000 }
      end
    end

    context 'on a holiday' do
      before do
        travel_to Time.zone.local(2021, 5, 1)  # ※ 土曜日
      end

      context 'in the morning' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 8) }

        it { is_expected.to eq 6_000_000 }
      end

      context 'in the noon' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 13) }

        it { is_expected.to eq 7_200_000 }
      end

      context 'in the nighter race' do
        let(:betting_deadline_at) { Time.zone.now.change(hour: 18) }

        it { is_expected.to eq 9_000_000 }
      end
    end
  end
end
