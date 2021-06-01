FactoryBot.define do
  factory :forecasting_pattern do
    name { 'イン逃げ鉄板' }
    race_filtering_condition {
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
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.5 }
            ]
          },
        ]
      }
    }
    first_place_filtering_condition {
      {
        and: [
          {
            '==': [
              { item: :itself, attribute: :pit_number },
              { item: :literal, value: 1 }
            ]
          },
          {
            '>': [
              { item: :itself, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :start_course_in_exhibition },
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
              { item: :itself, attribute: :winning_rate_in_event_going_stadium },
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
              { item: :itself, attribute: :winning_rate_in_event_going_stadium },
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
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 15 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
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
