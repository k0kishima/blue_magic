require 'rails_helper'

describe RacerPlacingRecordKpi, type: :model do
  describe '#value!' do
    subject { kpi.value! }

    # rubocop:disable Layout/LineLength
    let(:other_racer) { Racer.create(registration_number: 33333, last_name: '舟田') }
    let(:target_racer) { Racer.create(registration_number: 77777, last_name: 'エースモーターマン') }
    let(:racer_registration_number) { target_racer.registration_number }
    let(:race) { create(:race, date: Date.new(2021, 1, 1)) }
    let(:entry_object) {
      create(:race_entry, **race.slice(*Race.primary_keys), racer_registration_number: racer_registration_number, pit_number: 1)
    }
    let(:start_exhibition_record) {
      create(:start_exhibition_record, **race.slice(*Race.primary_keys), pit_number: 1, course_number: 1)
    }
    let(:aggregate_starts_on) { Date.new(2020, 1, 1) }
    let(:aggregate_ends_on) { Date.new(2020, 12, 31) }
    let(:race_entry_of_out_of_the_range_race_1) { create(:race_entry, date: aggregate_starts_on.yesterday, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_out_of_the_range_race_2) { create(:race_entry, date: aggregate_ends_on.tomorrow, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_1) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_2) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_3) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 6) }
    let(:race_entry_of_in_the_range_race_4) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:race_entry_of_in_the_range_race_5) { create(:race_entry, date: aggregate_ends_on, racer_registration_number: racer_registration_number, pit_number: 1) }
    let(:other_race_entry_of_in_the_range_race_1) { create(:race_entry, date: aggregate_starts_on, racer_registration_number: other_racer.registration_number, pit_number: 1) }
    # rubocop:enable Layout/LineLength

    context 'when data prepared' do
      before do
        start_exhibition_record
        kpi.entry_object = entry_object

        race_entry_of_out_of_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
        race_entry_of_out_of_the_range_race_2.create_race_record(course_number: 1, arrival: 1)
        race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
        race_entry_of_in_the_range_race_2.create_race_record(course_number: 1, arrival: 2)
        race_entry_of_in_the_range_race_3.create_race_record(course_number: 1, arrival: 1)
        race_entry_of_in_the_range_race_4.create_race_record(course_number: 2, arrival: 1)
        race_entry_of_in_the_range_race_5.create_race_record(course_number: 1, arrival: 3)
        other_race_entry_of_in_the_range_race_1.create_race_record(course_number: 1, arrival: 1)
      end

      context 'in kpi about first place rate' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_first_place_rate_on_start_course_in_exhibition_in_all_stadium') }

        it 'returns first place rate of specified racer' do
          expect(subject).to eq Rational(2, 4)
        end
      end

      context 'in kpi about second place rate' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_second_place_rate_on_start_course_in_exhibition_in_all_stadium') }

        it 'returns first place rate of specified racer' do
          expect(subject).to eq Rational(1, 4)
        end
      end

      context 'in kpi about third place rate' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_third_place_rate_on_start_course_in_exhibition_in_all_stadium') }

        it 'returns first place rate of specified racer' do
          expect(subject).to eq Rational(1, 4)
        end
      end
    end

    context 'when data not prepared' do
      let(:kpi) { Kpi.find_by(attribute_name: 'racer_first_place_rate_on_start_course_in_exhibition_in_all_stadium') }

      before do
        kpi.entry_object = entry_object
      end

      it { expect { subject }.to raise_error(DataNotPrepared) }
    end
  end
end
