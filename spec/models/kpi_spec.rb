require 'rails_helper'

class DummyCalculator
  def calculate!(entry_object)
    true
  end
end

RSpec.describe Kpi, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:entry_object_class_name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:attribute_name) }
    it { is_expected.to allow_value(nil).for(:entry_object) }
  end

  describe '#value!' do
    subject { kpi.value! }

    describe 'validation' do
      let(:kpi) {
        Kpi.find_by(entry_object_class_name: 'RaceEntry',
                    attribute_name: 'nige_succeed_rate_on_start_course_in_exhibition')
      }

      context 'when entry object is present' do
        before do
          kpi.entry_object = entry_object
        end

        context 'when entry object is an instance of specified class' do
          let(:entry_object) { build(:race_entry) }

          context 'when calculator is present' do
            before do
              kpi.calculator = DummyCalculator.new
            end

            it { is_expected.to be true }
          end

          context 'when calculator is blank' do
            it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
          end
        end

        context 'when entry object is not an instance of specified class' do
          let(:entry_object) { build(:race) }

          it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
        end
      end

      context 'when entry object is blank' do
        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end
  end
end

# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: kpis
#
#  id                                                                                                                                                                                      :bigint           not null, primary key
#  type                                                                                                                                                                                    :string(255)      not null
#  entry_object_class_name(値の算出をするために利用するオブジェクトのことをentry object と定義し、そのクラス名をここで指定（webpackのエントリーポイントとのアナロジーからこのように命名）) :string(255)      not null
#  name                                                                                                                                                                                    :string(255)      not null
#  description                                                                                                                                                                             :text(65535)
#  attribute_name                                                                                                                                                                          :string(255)      not null
#  created_at                                                                                                                                                                              :datetime         not null
#  updated_at                                                                                                                                                                              :datetime         not null
#
# Indexes
#
#  index_kpis_on_entry_object_class_name_and_attribute_name  (entry_object_class_name,attribute_name) UNIQUE
#
