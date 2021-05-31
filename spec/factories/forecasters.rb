FactoryBot.define do
  factory :forecaster do
    status { :active }
    name { 'ver1.0' }
    betting_strategy { :take_the_first_forecasting_pattern }
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id               :bigint           not null, primary key
#  status           :integer          not null
#  name             :string(255)      not null
#  description      :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  betting_strategy :integer
#
