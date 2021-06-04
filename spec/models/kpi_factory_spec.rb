require 'rails_helper'

describe KpiFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(hash: hash) }

    context 'when given hash has attribute key' do
      context 'when the value of key exist as a kpi' do
        let(:hash) { { item: 'itself', attribute: 'series_grade', } }
        let(:kpi) { Kpi.find_by!(attribute_name: 'series_grade') }

        it 'returns the kpi' do
          expect(subject).to eq kpi
        end
      end

      context 'when the value of key does not exist as a kpi' do
        let(:hash) { { item: 'itself', attribute: 'foobar', } }

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when given hash does not have attribute key' do
      let(:hash) { { item: 'itself', attr: 'series_grade', } }

      it { expect { subject }.to raise_error(KeyError) }
    end
  end

  describe '.create_recursively!' do
    subject { described_class.create_recursively!(hash: hash) }

    let(:series_grade_kpi) {
      Kpi.find_by!(attribute_name: 'series_grade')
    }
    let(:is_special_race_kpi) {
      Kpi.find_by!(attribute_name: 'is_special_race')
    }
    let(:hash) do
      {
        and: [
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
        ]
      }
    end

    it 'creates kpis recursively from the hash' do
      expect(subject).to eq [series_grade_kpi, is_special_race_kpi]
    end
  end
end
