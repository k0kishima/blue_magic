class MotorRenewal < ApplicationRecord
  include StadiumAssociating

  self.primary_keys = [:stadium_tel_code, :date]

  validates :date, presence: true
end

# == Schema Information
#
# Table name: motor_renewals
#
#  date             :date             not null, primary key
#  stadium_tel_code :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
