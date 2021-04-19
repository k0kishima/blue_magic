FactoryBot.define do
  factory :racer do
    sequence(:registration_number){|n| n}
  end
end

# == Schema Information
#
# Table name: racers
#
#  birth_date          :date
#  first_name          :string(255)      default(""), not null
#  gender              :integer
#  height              :integer
#  last_name           :string(255)      default(""), not null
#  registration_number :integer          not null, primary key
#  status              :integer
#  term                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  birth_prefecture_id :integer
#  branch_id           :integer
#
