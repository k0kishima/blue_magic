require 'rails_helper'

describe AnalysisFactory, type: :model do
  describe '.create!' do
    subject { described_class.create!(entry_object: entry_object, filtering_condition: filtering_condition) }

    let(:filtering_condition) do
      {
        and: [
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '>': [
              { item: :pit_number_1, attribute: :pit_number },
              { item: :literal, value: 1 }
            ]
          },
          {
            and: [
              {
                '>': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.5 }
                ]
              },
              {
                '<': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.7 }
                ]
              },
            ]
          }
        ]
      }
    end

    before do
      allow_any_instance_of(RacerWinningTrickKpi).to receive(:value!).and_return(0.7)
    end

    context 'when the entry object is specified correctly for the filtering condition' do
      let(:entry_object) { create(:race, :with_race_entries, title: '一般戦') }

      it 'creates a analysis object' do
        analysis = subject
        expect(analysis.is_special_race).to be false
        expect(analysis.pit_number_1.pit_number).to eq 1
        expect(analysis.pit_number_1.nige_succeed_rate_on_start_course_in_exhibition).to eq 0.7
      end
    end

    context 'when the entry object is not specified correctly for the filtering condition' do
      let(:entry_object) { create(:racer) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
