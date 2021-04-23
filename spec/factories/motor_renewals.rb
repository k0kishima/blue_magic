FactoryBot.define do
  factory :motor_renewal do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    date { Time.zone.today }
  end
end

# == Schema Information
#
# Table name: motor_renewals
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
