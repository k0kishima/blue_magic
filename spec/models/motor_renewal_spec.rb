require 'rails_helper'

describe MotorRenewal, type: :model do
  let(:motor_renewals) { create(:motor_renewal) }

  describe 'association' do
    subject { motor_renewals }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { motor_renewals }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:date) }
  end
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
