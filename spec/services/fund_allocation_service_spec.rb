require 'rails_helper'

RSpec.describe FundAllocationService, type: :model do
  describe '.call' do
    let(:budget_amount) { 10_000 }
    let(:target_amount) { 50_000 }

    subject do
      described_class.call(budget_amount: budget_amount, target_amount: target_amount, odds: odds,
                           fund_allocation_method: fund_allocation_method)
    end

    context 'when a valid fund allocation method given' do
      context 'when fund allocation method is CANCEL_IF_OVER_BUDGET' do
        let(:fund_allocation_method) { FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET }

        context 'when not over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                  })
          end
        end

        context 'when over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 4.9)
            ]
          end

          it 'raise OverBudget error' do
            expect { subject }.to raise_error OverBudget
          end
        end
      end

      context 'when fund allocation method is BET_WITHIN_BUDGET_BY_ASC' do
        let(:fund_allocation_method) { FundAllocationMethod::ID::BET_WITHIN_BUDGET_BY_ASC }

        context 'when not over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                  })
          end
        end

        context 'when over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10),
              Odds.new(betting_number: 125, ratio: 20)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                  })
          end
        end
      end

      context 'when fund allocation method is BET_WITHIN_BUDGET_BY_DESC' do
        let(:fund_allocation_method) { FundAllocationMethod::ID::BET_WITHIN_BUDGET_BY_DESC }

        context 'when not over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                  })
          end
        end

        context 'when over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10),
              Odds.new(betting_number: 125, ratio: 20)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    125 => 25.0,
                                    124 => 50.0,
                                  })
          end
        end
      end

      context 'when fund allocation method is ALL_BET' do
        let(:fund_allocation_method) { FundAllocationMethod::ID::ALL_BET }

        context 'when not over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                  })
          end
        end

        context 'when over budget' do
          let(:odds) do
            [
              Odds.new(betting_number: 123, ratio: 10),
              Odds.new(betting_number: 124, ratio: 10),
              Odds.new(betting_number: 125, ratio: 20)
            ]
          end

          it 'returns should purchase betting numbers and quantity' do
            expect(subject).to eq({
                                    123 => 50.0,
                                    124 => 50.0,
                                    125 => 25.0,
                                  })
          end
        end
      end
    end

    context 'when an unknown fund allocation method given' do
      let(:fund_allocation_method) { 9999 }
      let(:odds) do
        [
          Odds.new(betting_number: 123, ratio: 3.1)
        ]
      end

      it 'raise ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
