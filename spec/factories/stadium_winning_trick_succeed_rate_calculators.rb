FactoryBot.define do
  factory :stadium_winning_trick_succeed_rate_calculator do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    course_number { 1 }
    trick { WinningTrick::Nige.instance }
  end
end
