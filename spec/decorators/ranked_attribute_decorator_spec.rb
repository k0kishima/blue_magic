require 'rails_helper'

class DummyModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :score, :integer
end

describe RankedAttributeDecorator, type: :model do
  describe '.bulk_decorate!' do
    subject {
      described_class.bulk_decorate!(objects: objects, need_to_rank_attribute_name: need_to_rank_attribute_name,
                                     evaluation_policy: evaluation_policy)
    }

    context 'when a list which includes all of same type objects' do
      context 'when existing attribute specified' do
        let(:need_to_rank_attribute_name) { :score }

        context 'when specified attributes which have a value' do
          let(:objects) { [DummyModel.new(score: 3), DummyModel.new(score: 1), DummyModel.new(score: 2)] }

          context 'when evaluation_policy is bigger_is_better' do
            let(:evaluation_policy) { :bigger_is_better }

            it 'adds rank accessors to objects and substitutes value' do
              subject
              expect(objects.map(&:score_rank)).to eq [1, 3, 2]
            end
          end

          context 'when evaluation_policy is not bigger_is_better' do
            let(:evaluation_policy) { :smaller_is_better }

            it 'adds rank accessors to objects and substitutes value' do
              subject
              expect(objects.map(&:score_rank)).to eq [3, 1, 2]
            end
          end
        end

        context 'when any specified attributes which have blank value' do
          let(:objects) { [DummyModel.new(score: 3), DummyModel.new(score: nil)] }
          let(:evaluation_policy) { :bigger_is_better }

          it { expect { subject }.to raise_error(DataNotFound) }
        end
      end

      context 'when not existing attribute specified' do
        let(:objects) { [DummyModel.new(score: 3), DummyModel.new(score: 1)] }
        let(:need_to_rank_attribute_name) { :motor_quinella_rate }
        let(:evaluation_policy) { :bigger_is_better }

        it { expect { subject }.to raise_error(NoMethodError) }
      end
    end

    context 'when a list which includes object of various type' do
      let(:objects) { [build(:race_entry), build(:boat_setting)] }
      let(:need_to_rank_attribute_name) { :motor_quinella_rate }
      let(:evaluation_policy) { :smaller_is_better }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
