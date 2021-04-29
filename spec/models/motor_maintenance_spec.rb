require 'rails_helper'

describe MotorMaintenance, type: :model do
  let(:motor_maintenance) { create(:motor_maintenance) }

  describe 'association' do
    subject { motor_maintenance }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { motor_maintenance }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:race_number) }
    it { is_expected.to validate_inclusion_of(:race_number).in_range(1..12) }
    it { is_expected.to validate_presence_of(:exchanged_parts) }
    it { is_expected.to validate_presence_of(:quantity) }
    it {
      is_expected.to validate_numericality_of(:quantity)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(10)
    }
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
