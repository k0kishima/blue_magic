require 'rails_helper'

describe FetchBettingResultJob, type: :job do
  shared_examples :be_discarded do
    it 'does not perform job' do
      assert_no_performed_jobs do
        subject
      end
    end
  end

  describe '#perform_now' do
    subject do
      described_class.perform_now(date: date, stadium_tel_code: stadium_tel_code, race_number: race_number,)
    end

    let(:date) { Date.new(2021, 6, 24) }
    let(:stadium_tel_code) { 4 }
    let(:race_number) { 12 }

    context 'when a specified race exist' do
      let(:race) { create(:race, stadium_tel_code: stadium_tel_code, date: date, race_number: race_number) }

      before do
        race
      end

      context 'when the race has bettings' do
        let(:forecaster) { create(:forecaster) }
        let(:forecasting_pattern_1) { create(:forecasting_pattern) }
        let(:forecasting_pattern_2) { create(:forecasting_pattern) }
        let(:forecasters_forecasting_pattern_1) do
          create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_1,)
        end
        let(:forecasters_forecasting_pattern_2) do
          create(:forecasters_forecasting_pattern, forecaster: forecaster, forecasting_pattern: forecasting_pattern_2,)
        end
        let(:recommend_odds_1) do
          create(
            :recommend_odds,
            forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_1.id,
            **race.slice(*Race.primary_keys),
            betting_number: 123,
            ratio_when_forecasting: 10,
            should_purchase_quantity: 30
          )
        end
        let(:recommend_odds_2) do
          create(
            :recommend_odds,
            forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_1.id,
            **race.slice(*Race.primary_keys),
            betting_number: 124,
            ratio_when_forecasting: 20,
            should_purchase_quantity: 15
          )
        end
        let(:recommend_odds_3) do
          create(
            :recommend_odds,
            forecasters_forecasting_pattern_id: forecasters_forecasting_pattern_2.id,
            **race.slice(*Race.primary_keys),
            betting_number: 123,
            ratio_when_forecasting: 30,
            should_purchase_quantity: 10
          )
        end

        before do
          create(:betting,
                 **recommend_odds_1.attributes.slice(*RecommendOdds.primary_keys),
                 betting_number: 123,
                 betting_amount: 3_000,
                 dry_run: dry_run)
          create(:betting,
                 **recommend_odds_2.attributes.slice(*RecommendOdds.primary_keys),
                 betting_number: 124,
                 betting_amount: 1_500,
                 dry_run: dry_run)
          create(:betting,
                 **recommend_odds_3.attributes.slice(*RecommendOdds.primary_keys),
                 betting_number: 123,
                 betting_amount: 1_000,
                 dry_run: dry_run)
        end

        context 'when the race already has a result' do
          context 'when dry_run is enable' do
            let(:dry_run) { true }

            before do
              allow_any_instance_of(SimulateOddsRatioDecreaseService).to receive(:call).and_return(3)
              create(:payoff, **race.slice(*Race.primary_keys), betting_number: 123, amount: 900)
            end

            it 'オッズの減少が考慮された上でベットデータが更新されること' do
              expect { subject }.to change { Betting.count }.by(0)
              expect(Betting.all).to contain_exactly(
                have_attributes(
                  **recommend_odds_1.attributes.slice(*RecommendOdds.primary_keys),
                  betting_number: 123,
                  betting_amount: 3000,
                  refunded_amount: 27000,
                  adjustment_amount: 300,
                ),
                have_attributes(
                  **recommend_odds_2.attributes.slice(*RecommendOdds.primary_keys),
                  betting_number: 124,
                  betting_amount: 1500,
                  refunded_amount: 0,
                  adjustment_amount: 0,
                ),
                have_attributes(
                  **recommend_odds_3.attributes.slice(*RecommendOdds.primary_keys),
                  betting_number: 123,
                  betting_amount: 1000,
                  refunded_amount: 9000,
                  adjustment_amount: 300,
                ),
              )
            end
          end

          context 'when dry_run is disable' do
            let(:dry_run) { false }

            context '同着なしのとき' do
              before do
                create(:payoff, **race.slice(*Race.primary_keys), betting_number: 123, amount: 900)
              end

              it 'ベットデータが更新されること' do
                expect { subject }.to change { Betting.count }.by(0)
                expect(Betting.all).to contain_exactly(
                  have_attributes(
                    **recommend_odds_1.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 123,
                    betting_amount: 3000,
                    refunded_amount: 27000,
                    adjustment_amount: 0,
                  ),
                  have_attributes(
                    **recommend_odds_2.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 124,
                    betting_amount: 1500,
                    refunded_amount: 0,
                    adjustment_amount: 0,
                  ),
                  have_attributes(
                    **recommend_odds_3.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 123,
                    betting_amount: 1000,
                    refunded_amount: 9000,
                    adjustment_amount: 0,
                  ),
                )
              end
            end

            context '同着ありのとき' do
              before do
                create(:payoff, **race.slice(*Race.primary_keys), betting_number: 123, amount: 900)
                create(:payoff, **race.slice(*Race.primary_keys), betting_number: 124, amount: 1000)
              end

              it 'ベットデータが更新されること' do
                expect { subject }.to change { Betting.count }.by(0)
                expect(Betting.all).to contain_exactly(
                  have_attributes(
                    **recommend_odds_1.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 123,
                    betting_amount: 3000,
                    refunded_amount: 27000,
                    adjustment_amount: 0,
                  ),
                  have_attributes(
                    **recommend_odds_2.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 124,
                    betting_amount: 1500,
                    refunded_amount: 15000,
                    adjustment_amount: 0,
                  ),
                  have_attributes(
                    **recommend_odds_3.attributes.slice(*RecommendOdds.primary_keys),
                    betting_number: 123,
                    betting_amount: 1000,
                    refunded_amount: 9000,
                    adjustment_amount: 0,
                  ),
                )
              end
            end
          end
        end

        context 'when the race does not have a result' do
          let(:dry_run) { true }

          it_behaves_like :be_discarded
        end
      end

      context 'when the race does not have any bettings' do
        it_behaves_like :be_discarded
      end
    end

    context 'when a specified race does not exist' do
      it_behaves_like :be_discarded
    end
  end
end
