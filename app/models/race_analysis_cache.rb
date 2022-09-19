class RaceAnalysisCache < ApplicationRecord
  class RaceCannotBeAnalyzed < StandardError; end

  belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true

  def race_data
    Hashie::Mash.new(data)
  end

  # dataは複数形らしいが、race_entry_data だとコレクションのニュアンスが薄いのでこの名前にした
  def race_entries_data
    pit_number_attribute_names = Pit::NUMBER_RANGE.to_a.map{|n| "pit_number_#{n}" }

    race_entry_attributes = data.deep_dup
    race_attributes = race_entry_attributes.slice!(*pit_number_attribute_names)

    pit_number_attribute_names.map do |pit_number_n|
      d = race_entry_attributes.fetch(pit_number_n)
      d['race'] = race_attributes
      Hashie::Mash.new(d)
    end
  end
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
