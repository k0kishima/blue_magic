require 'rails_helper'

describe RacerRatingEvaluationTerm, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:starts_on) }
    it { is_expected.to validate_presence_of(:ends_on) }

    describe 'starts_on' do
      let(:racer_rating_evaluation_term) { described_class.new(starts_on: Date.new(2020, month, day)) }

      before do
        racer_rating_evaluation_term.valid?
      end

      context 'with May of some year' do
        let(:month) { 5 }

        context 'with the 1st of May' do
          let(:day) { 1 }

          it 'does not have any errors on starts_on' do
            expect(racer_rating_evaluation_term.errors).to_not include 'starts_on'
          end
        end

        context 'with the not 1st of May' do
          let(:day) { 2 }

          it 'has a error on starts_on' do
            expect(racer_rating_evaluation_term.errors).to include 'starts_on'
          end
        end
      end

      context 'with Novenber of some year' do
        let(:month) { 11 }

        context 'with the 1st of Novenber' do
          let(:day) { 1 }

          it 'does not have any errors on starts_on' do
            expect(racer_rating_evaluation_term.errors).to_not include 'starts_on'
          end
        end

        context 'with the not 1st of Novenber' do
          let(:day) { 2 }

          it 'has a error on starts_on' do
            expect(racer_rating_evaluation_term.errors).to include 'starts_on'
          end
        end
      end

      context 'with a month which is not May and Novenber of some year' do
        let(:month) { 12 }
        let(:day) { 1 }

        it 'has a error on starts_on' do
          expect(racer_rating_evaluation_term.errors).to include 'starts_on'
        end
      end
    end

    describe 'ends_on' do
      let(:racer_rating_evaluation_term) { described_class.new(ends_on: Date.new(2020, month, day)) }

      before do
        racer_rating_evaluation_term.valid?
      end

      context 'with April of some year' do
        let(:month) { 4 }

        context 'with the end of April' do
          let(:day) { 30 }

          it 'does not have any errors on ends_on' do
            expect(racer_rating_evaluation_term.errors).to_not include 'ends_on'
          end
        end

        context 'with the not end of April' do
          let(:day) { 29 }

          it 'has a error on ends_on' do
            expect(racer_rating_evaluation_term.errors).to include 'ends_on'
          end
        end
      end

      context 'with October of some year' do
        let(:month) { 10 }

        context 'with the end of October' do
          let(:day) { 31 }

          it 'does not have any errors on ends_on' do
            expect(racer_rating_evaluation_term.errors).to_not include 'ends_on'
          end
        end

        context 'with the not end of October' do
          let(:day) { 30 }

          it 'has a error on ends_on' do
            expect(racer_rating_evaluation_term.errors).to include 'ends_on'
          end
        end
      end

      context 'with a month which is not April and October of some year' do
        let(:month) { 5 }
        let(:day) { 1 }

        it 'has a error on ends_on' do
          expect(racer_rating_evaluation_term.errors).to include 'ends_on'
        end
      end
    end
  end

  describe '#calculate_debut_term!' do
    subject { racer_rating_evaluation_term.calculate_debut_term! }

    describe '2020年前期' do
      let(:racer_rating_evaluation_term) {
        described_class.initialize_by(date: Date.new(2020, described_class::FIRST_HALF_START_MONTH))
      }

      it { is_expected.to eq 126 }
    end

    describe '2020年後期' do
      let(:racer_rating_evaluation_term) {
        described_class.initialize_by(date: Date.new(2020, described_class::SECOND_HALF_START_MONTH))
      }

      it { is_expected.to eq 127 }
    end

    describe '2021年前期' do
      let(:racer_rating_evaluation_term) {
        described_class.initialize_by(date: Date.new(2021, described_class::FIRST_HALF_START_MONTH))
      }

      it { is_expected.to eq 128 }
    end

    describe '2021年後期' do
      let(:racer_rating_evaluation_term) {
        described_class.initialize_by(date: Date.new(2021, described_class::SECOND_HALF_START_MONTH))
      }

      it { is_expected.to eq 129 }
    end
  end
end
