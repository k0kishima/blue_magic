require 'rails_helper'

describe Forecaster, type: :model do
  let(:forecaster) { create(:forecaster) }

  describe 'validations' do
    subject { forecaster }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:reduce_odds_method) }
    it { is_expected.to validate_inclusion_of(:reduce_odds_method).in_array(ReduceOddsMethod.all) }
  end
end

# == Schema Information
#
# Table name: forecasters
#
#  id                 :bigint           not null, primary key
#  status             :integer          not null
#  name               :string(255)      not null
#  description        :text(65535)
#  reduce_odds_method :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
