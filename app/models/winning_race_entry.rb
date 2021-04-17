class WinningRaceEntry < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]
  belongs_to :race_record, foreign_key: [:stadium_tel_code, :date, :race_number, :pit_number], optional: true

  enum winning_trick: { nige: ::WinningTrick::ID::NIGE,
                        sashi: ::WinningTrick::ID::SASHI,
                        makuri: ::WinningTrick::ID::MAKURI,
                        makurizashi: ::WinningTrick::ID::MAKURIZASHI,
                        nuki: ::WinningTrick::ID::NUKI,
                        megumare: ::WinningTrick::ID::MEGUMARE, }

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :winning_trick, presence: true

  def winning_trick_id
    self.class.winning_tricks[winning_trick.to_s]
  end
end
