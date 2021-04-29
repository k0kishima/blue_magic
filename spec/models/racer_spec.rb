require 'rails_helper'

describe Racer, type: :model do
  let(:racer) { create(:racer) }

  describe 'validations' do
    subject { racer }

    let(:current_term) { 100 }
    let(:term_double) { class_double(RacerRatingEvaluationTerm) }
    let(:term_instance_double) { instance_double(RacerRatingEvaluationTerm) }

    before do
      stub_const('RacerRatingEvaluationTerm', term_double)
      allow(term_double).to receive(:initialize_by).and_return(term_instance_double)
      allow(term_instance_double).to receive(:calculate_debut_term!).and_return(current_term)
    end

    it { is_expected.to validate_uniqueness_of(:registration_number) }
    it { is_expected.to validate_inclusion_of(:branch_id).in_array(Stadium.pluck(:prefecture_id)) }
    it { is_expected.to validate_inclusion_of(:birth_prefecture_id).in_range(1..47) }

    describe 'term' do
      let(:racer) { build(:racer, term: term) }

      before do
        racer.valid?
      end

      context 'term is less than or equal to latest term' do
        let(:term) { 100 }

        it 'does not have any errors on term' do
          expect(racer.errors).to_not include 'term'
        end
      end

      context 'term is greater than latest term' do
        let(:term) { 101 }

        it 'does not have any errors on term' do
          expect(racer.errors).to include 'term'
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: racers
#
#  registration_number :integer          not null, primary key
#  last_name           :string(255)      default(""), not null
#  first_name          :string(255)      default(""), not null
#  gender              :integer
#  term                :integer
#  birth_date          :date
#  branch_id           :integer
#  birth_prefecture_id :integer
#  height              :integer
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
