FactoryBot.define do
  factory :forecaster do
    status { :active }
    name { 'ver1.0' }
    reduce_odds_method { ReduceOddsMethod::ID::TAKE_THE_FIRST }
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id                 :bigint           not null, primary key
#  status             :integer          not null
#  name               :string(255)      not null
#  description        :text(65535)
#  reduce_odds_method :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
