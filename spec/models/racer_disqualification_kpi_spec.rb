require 'rails_helper'

describe RacerAssistTrickKpi, type: :model do
  describe '#value!' do
    subject { kpi.value! }

    let(:target_racer_registration_number) { 1 }
    let(:other_racer_registration_number) { 2 }
    let(:race_1) { create(:race, date: Date.new(2021, 4, 30), betting_deadline_at: DateTime.new(2021, 4, 30, 9)) }
    let(:race_2) { create(:race, date: Date.new(2021, 5, 1), betting_deadline_at: DateTime.new(2021, 5, 1, 9)) }
    let(:race_3) { create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 9)) }
    let(:race_4) { create(:race, date: Date.new(2021, 6, 6), betting_deadline_at: DateTime.new(2021, 6, 6, 14)) }
    let(:race_entry_1) { create(:race_entry, **race_1.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number) }
    let(:race_entry_2) { create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number) }
    let(:race_entry_3) { create(:race_entry, **race_3.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number) }
    let(:race_entry_4) { create(:race_entry, **race_4.slice(*Race.primary_keys), racer_registration_number: target_racer_registration_number) }
    let(:other_race_entry) { create(:race_entry, **race_2.slice(*Race.primary_keys), racer_registration_number: other_racer_registration_number) }

    context 'in a kpi about current term' do
      describe ' disqualification total kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_disqualification_total_in_current_term') }

        before do
          kpi.entry_object = race_entry_4
    
          # 前期の失格は含まない
          create(:disqualified_race_entry, **race_1.slice(*Race.primary_keys), pit_number: race_entry_1.pit_number, disqualification: Disqualification::ID::FLYING)
    
          # 集計期間中
          ## 対象レーサーなので含む
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: race_entry_2.pit_number, disqualification: Disqualification::ID::ABSENT)
          create(:disqualified_race_entry, **race_3.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number, disqualification: Disqualification::ID::FLYING)
          ## 対象レーサーではないので含まない
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: other_race_entry.pit_number, disqualification: Disqualification::ID::FLYING)
    
          # 集計対象のレースでの失格は含まない
          create(:disqualified_race_entry, **race_4.slice(*Race.primary_keys), pit_number: race_entry_4.pit_number, disqualification: Disqualification::ID::FLYING)
        end
    
  
        it 'returns disqualification total count' do
          expect(subject).to eq 2
        end
      end

      describe 'flying count kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_flying_count_in_current_term') }

        before do
          kpi.entry_object = race_entry_4
    
          # 前期の失格は含まない
          create(:disqualified_race_entry, **race_1.slice(*Race.primary_keys), pit_number: race_entry_1.pit_number, disqualification: Disqualification::ID::FLYING)
    
          # 集計期間中
          ## 対象レーサーなので含む
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: race_entry_2.pit_number, disqualification: Disqualification::ID::FLYING)
          create(:disqualified_race_entry, **race_3.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number, disqualification: Disqualification::ID::FLYING)
          ## 対象レーサーではないので含まない
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: other_race_entry.pit_number, disqualification: Disqualification::ID::FLYING)
    
          # 集計対象のレースでの失格は含まない
          create(:disqualified_race_entry, **race_4.slice(*Race.primary_keys), pit_number: race_entry_4.pit_number, disqualification: Disqualification::ID::FLYING)
        end
    
  
        it 'returns flying count' do
          expect(subject).to eq 2
        end
      end

      describe 'lateness count kpi' do
        let(:kpi) { Kpi.find_by(attribute_name: 'racer_lateness_count_in_current_term') }

        before do
          kpi.entry_object = race_entry_4
    
          # 前期の失格は含まない
          create(:disqualified_race_entry, **race_1.slice(*Race.primary_keys), pit_number: race_entry_1.pit_number, disqualification: Disqualification::ID::LATENESS)
    
          # 集計期間中
          ## 対象レーサーなので含む
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: race_entry_2.pit_number, disqualification: Disqualification::ID::LATENESS)
          create(:disqualified_race_entry, **race_3.slice(*Race.primary_keys), pit_number: race_entry_3.pit_number, disqualification: Disqualification::ID::LATENESS)
          ## 対象レーサーではないので含まない
          create(:disqualified_race_entry, **race_2.slice(*Race.primary_keys), pit_number: other_race_entry.pit_number, disqualification: Disqualification::ID::LATENESS)
    
          # 集計対象のレースでの失格は含まない
          create(:disqualified_race_entry, **race_4.slice(*Race.primary_keys), pit_number: race_entry_4.pit_number, disqualification: Disqualification::ID::LATENESS)
        end
  
        it 'returns lateness count' do
          expect(subject).to eq 2
        end
      end
    end
  end
end
