require 'rails_helper'

describe Racer, type: :model do
  let(:racer) { create(:racer) }

  describe 'validations' do
    subject { racer }

    it { is_expected.to validate_uniqueness_of(:registration_number) }
    it { is_expected.to validate_inclusion_of(:branch_id).in_array(Stadium.pluck(:prefecture_id)) }
    it { is_expected.to validate_inclusion_of(:birth_prefecture_id).in_range(1..47) }
  end
end

# == Schema Information
#
# Table name: racers
#
#  registration_number :integer          not null, primary key
#  last_name           :string(255)      default(""), not null
#  first_name          :string(255)      default(""), not null
#  gender              :integer
#  term                :integer
#  birth_date          :date
#  branch_id           :integer
#  birth_prefecture_id :integer
#  height              :integer
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
