require 'rails_helper'

describe EventHolding, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:stadium_tel_code) }
    it { is_expected.to validate_inclusion_of(:stadium_tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:date) }
  end
end
