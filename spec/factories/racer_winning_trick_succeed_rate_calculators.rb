FactoryBot.define do
  factory :racer_winning_trick_succeed_rate_calculator do
    sequence(:racer_registration_number) { |n| n }
    course_number { 1 }
    trick { WinningTrick::Nige.instance }
  end
end
