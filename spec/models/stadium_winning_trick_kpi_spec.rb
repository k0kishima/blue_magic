require 'rails_helper'

RSpec.describe StadiumWinningTrickKpi, type: :model do
  let(:kpi) { Kpi.find_by(attribute_name: 'nige_succeed_rate_of_stadium_in_current_weather_condition') }

  describe '#value!' do
    subject { kpi.value! }

    context 'when an entry object is present' do
      before do
        kpi.entry_object = entry_object
      end

      context 'when the entry object is a race' do
        let(:entry_object) { create(:race) }

        context 'when the race has weather information in exhibition' do
          let!(:weather_condition_in_exhibition) {
            create(:weather_condition, race: entry_object, in_performance: false)
          }

          it 'returns value' do
            expect(subject).to eq 0
          end
        end

        context 'when race does not have weather information in exhibition' do
          it { expect { subject }.to raise_error(DataNotPrepared) }
        end
      end

      context 'when the entry object is not a race' do
        let(:entry_object) { build(:race_entry) }

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
