FactoryBot.define do
  factory :forecasting_pattern do
    name { 'イン逃げ鉄板' }
    race_filtering_condition {
      {
        and: [
          {
            '>': [
              { item: :race_entry, modifier: [:pit_number, 1],
                attr: :in_nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '==': [
              { item: :race_entry, modifier: [:pit_number, 1], attr: :start_course_in_exhibition },
              { item: :literal, value: 1 }
            ]
          }
        ]
      }
    }
    first_place_filtering_condition {
      {
        and: [
          {
            '==': [
              { item: :itself, attr: :pit_number },
              { item: :literal, value: 1 }
            ]
          },
          {
            '>': [
              { item: :itself, attr: :in_nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '==': [
              { item: :itself, attr: :start_course_in_exhibition },
              { item: :literal, value: 1 }
            ]
          }
        ]
      }
    }
    second_place_filtering_condition {
      {
        and: [
          {
            '>': [
              { item: :itself, attr: :winning_rate_in_event_going_stadium },
              { item: :literal, value: 5 }
            ]
          }
        ]
      }
    }
    third_place_filtering_condition {
      {
        and: [
          {
            '>': [
              { item: :itself, attr: :winning_rate_in_event_going_stadium },
              { item: :literal, value: 3.5 }
            ]
          }
        ]
      }
    }
    odds_filtering_condition {
      {
        and: [
          {
            '>=': [
              { item: :itself, attr: :ratio },
              { item: :literal, value: 15 }
            ]
          },
          {
            '<=': [
              { item: :itself, attr: :ratio },
              { item: :literal, value: 50 }
            ]
          }
        ]
      }
    }
  end
end

# == Schema Information
#
# Table name: forecasting_patterns
#
#  id                               :bigint           not null, primary key
#  name                             :string(255)      not null
#  description                      :text(65535)
#  race_filtering_condition         :json             not null
#  first_place_filtering_condition  :json             not null
#  second_place_filtering_condition :json             not null
#  third_place_filtering_condition  :json             not null
#  odds_filtering_condition         :json             not null
#  frozen_at                        :datetime
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
