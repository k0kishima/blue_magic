FactoryBot.define do
  factory :racer do
    sequence(:registration_number){|n| n}
  end
end

# == Schema Information
#
# Table name: racers
#
#  registration_number :integer          not null, primary key
#  last_name           :string(255)      default(""), not null
#  first_name          :string(255)      default(""), not null
#  gender              :integer
#  term                :integer
#  birth_date          :date
#  branch_id           :integer
#  birth_prefecture_id :integer
#  height              :integer
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
