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
