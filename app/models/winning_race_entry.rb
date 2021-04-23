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

# == Schema Information
#
# Table name: winning_race_entries
#
#  stadium_tel_code :integer          not null, primary key
#  date             :date             not null, primary key
#  race_number      :integer          not null, primary key
#  pit_number       :integer          not null, primary key
#  winning_trick    :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
