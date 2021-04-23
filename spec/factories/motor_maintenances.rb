FactoryBot.define do
  factory :motor_maintenance do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    date { Time.zone.today }
    sequence(:race_number, Race.numbers.cycle)
    sequence(:motor_number) {|n| n }
    exchanged_parts { :electrical_system }
    quantity { 1 }
  end
end

# == Schema Information
#
# Table name: motor_maintenances
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  motor_number     :integer          not null, primary key
#  exchanged_parts  :integer          not null, primary key
#  quantity         :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
