require 'rails_helper'

describe AttributionalKpi, type: :model do
  let(:kpi) { Kpi.find_by(attribute_name: 'is_special_race') }

  describe '#value!' do
    subject { kpi.value! }

    context 'when an entry object is present' do
      before do
        kpi.entry_object = entry_object
      end

      context 'when the entry object is matched to specified class' do
        let(:entry_object) { build(:race, title: '特選') }

        it 'returns value' do
          expect(subject).to eq true
        end
      end

      context 'when the entry object is not matched to specified class' do
        let(:entry_object) { build(:racer) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end

    context 'when an entry object is blank' do
      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end

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
#  index_kpis_on_attribute_name  (attribute_name) UNIQUE
#
