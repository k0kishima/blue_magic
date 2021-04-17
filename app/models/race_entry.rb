class RaceEntry < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  scope :absent, -> {
    joins(:disqualified_race_entry)
      .merge(DisqualifiedRaceEntry.where(disqualification: Disqualification::ID::ABSENT))
  }
  scope :not_absent, -> {
    left_joins(:disqualified_race_entry)
      .where(disqualified_race_entries: { disqualification: [nil, *Disqualification.cannnot_pre_fetchable_ids] })
  }

  has_one :race_exhibition_record, foreign_key: self.primary_keys
  has_one :race_record, foreign_key: self.primary_keys
  has_one :boat_setting, foreign_key: self.primary_keys
  has_one :disqualified_race_entry, foreign_key: self.primary_keys

  belongs_to :racer, foreign_key: :racer_registration_number, optional: true
  belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :racer_registration_number, presence: true

  delegate :motor_number, to: :boat_setting
  delegate :course_number, :start_time, :exhibition_time, :exhibition_time_order, to: :race_exhibition_record
  alias_method :start_course_in_exhibition, :course_number
  alias_method :start_time_in_exhibition, :start_time

  def absent?
    disqualified_race_entry.present? && disqualified_race_entry.disqualification == Disqualification::ID::ABSENT
  end
end
