require 'rails_helper'

RSpec.describe Stadium, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:tel_code) }
    it { is_expected.to validate_uniqueness_of(:tel_code) }
    it { is_expected.to validate_inclusion_of(:tel_code).in_range(1..24) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:prefecture_id) }
    it { is_expected.to validate_inclusion_of(:prefecture_id).in_range(1..47) }
    it { is_expected.to validate_presence_of(:water_quality) }
    it { is_expected.to allow_value(true).for(:tide_fluctuation) }
    it { is_expected.to allow_value(false).for(:tide_fluctuation) }
    it { is_expected.not_to allow_value(nil).for(:tide_fluctuation) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:elevation) }
  end
end

# == Schema Information
#
# Table name: stadiums
#
#  tel_code         :integer          not null, primary key
#  name             :string(255)      not null
#  prefecture_id    :integer          not null
#  water_quality    :integer          not null
#  tide_fluctuation :boolean          not null
#  lat              :float(24)        not null
#  lng              :float(24)        not null
#  elevation        :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
