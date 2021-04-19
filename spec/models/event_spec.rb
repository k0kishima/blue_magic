require 'rails_helper'

describe Event, type: :model do
  let(:event) { create(:event) }

  describe 'association' do
    subject { event }

    it { is_expected.to belong_to(:stadium) }
  end

  describe 'validations' do
    subject { event }

    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:starts_on) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:grade) }
    it { is_expected.to validate_presence_of(:kind) }
  end
end

# == Schema Information
#
# Table name: events
#
#  canceled         :boolean          default(FALSE), not null
#  grade            :integer          not null
#  kind             :integer          not null
#  stadium_tel_code :integer          not null, primary key
#  starts_on        :date             not null, primary key
#  title            :string(255)      not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
