require 'rails_helper'

describe Kpi::RaceEntry::Base, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:pit_number) }
  end
end
