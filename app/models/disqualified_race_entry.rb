class DisqualifiedRaceEntry < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]
  belongs_to :race_entry, foreign_key: self.primary_keys, optional: true

  enum disqualification: {
    capsize: Disqualification::ID::CAPSIZE,
    fall: Disqualification::ID::FALL,
    sinking: Disqualification::ID::SINKING,
    violation: Disqualification::ID::VIOLATION,
    disqualification_after_start: Disqualification::ID::DISQUALIFICATION_AFTER_START,
    engine_stop: Disqualification::ID::ENGINE_STOP,
    unfinished: Disqualification::ID::UNFINISHED,
    repayment_other_than_flying_and_lateness: Disqualification::ID::REPAYMENT_OTHER_THAN_FLYING_AND_LATENESS,
    flying: Disqualification::ID::FLYING,
    lateness: Disqualification::ID::LATENESS,
    absent: Disqualification::ID::ABSENT,
  }

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :disqualification, presence: true
end

# == Schema Information
#
# Table name: disqualified_race_entries
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  disqualification :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
