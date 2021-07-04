class RaceAnalysisCache < ApplicationRecord
end

# == Schema Information
#
# Table name: race_analysis_caches
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  data             :json
#  error_message    :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
