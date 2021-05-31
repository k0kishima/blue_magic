require 'rails_helper'

describe RacerWinningTrickKpi, type: :model do
  let(:kpi) { Kpi.find_by(attribute_name: 'nige_succeed_rate_on_start_course_in_exhibition') }

  describe '#value!' do
    subject { kpi.value! }

    context 'when an entry object is present' do
      let(:race) { create(:race, :with_race_entries) }

      before do
        kpi.entry_object = entry_object
      end

      context 'when the entry object is a race entry' do
        let(:entry_object) { race.race_entries.first }

        context 'when the race entry has start exhibition record' do
          let!(:start_exhibition_record) {
            create(:start_exhibition_record, **race.slice(*Race.primary_keys), pit_number: 1, course_number: 1)
          }

          it 'returns value' do
            expect(subject).to eq 0
          end
        end

        context 'when the race entry does not have start exhibition record' do
          it { expect { subject }.to raise_error(DataNotPrepared) }
        end
      end

      context 'when the entry object is not a race entry' do
        let(:entry_object) { race }

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
#  index_kpis_on_entry_object_class_name_and_attribute_name  (entry_object_class_name,attribute_name) UNIQUE
#
