require 'rails_helper'

RSpec.describe SimulateOddsRatioDecreaseService, type: :service do
  describe '.call' do
    subject do
      described_class.call(before_purchase_total_sales_per_one_race: before_purchase_total_sales_per_one_race,
                           odds_ratio: odds_ratio,
                           purchase_amount: purchase_amount)
    end

    let(:before_purchase_total_sales_per_one_race) { 4_000_000 }
    let(:odds_ratio) { 100 }
    let(:purchase_amount) { 10_000 }

    it 'calculates decrease ratio' do
      expect(subject).to eq 75.04678727386151
    end
  end
end
