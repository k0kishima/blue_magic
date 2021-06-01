require 'rails_helper'

describe Forecaster, type: :model do
  describe 'validations' do
    subject { forecaster }

    let(:forecaster) { create(:forecaster) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:betting_strategy) }
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id               :bigint           not null, primary key
#  status           :integer          not null
#  name             :string(255)      not null
#  description      :text(65535)
#  betting_strategy :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
