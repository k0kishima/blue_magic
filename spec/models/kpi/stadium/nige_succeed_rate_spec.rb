require 'rails_helper'

describe Kpi::Stadium::NigeSucceedRate, type: :model do
  let(:kpi) { described_class.instance }

  describe '#aggregate!' do
    subject {
      kpi.aggregate!(stadium_tel_code: stadium_tel_code, course_number: course_number,
                     aggregation_range: aggregate_starts_on..aggregate_ends_on, context: context)
    }

    let(:aggregate_starts_on) { Date.new(2020, 12, 1) }
    let(:aggregate_ends_on) { Date.new(2020, 12, 3) }
    let(:stadium_tel_code) { 4 }
    let(:course_number) { 1 }
    let(:context) { {} }

    it 'returns a kpi aggregation' do
      expect(subject).to have_attributes(
        kpi: kpi,
        value: 0,
        aggregate_starts_on: aggregate_starts_on,
        aggregate_ends_on: aggregate_ends_on,
      )
    end
  end
end
