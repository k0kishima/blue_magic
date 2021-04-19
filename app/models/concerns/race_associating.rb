module RaceAssociating
  extend ActiveSupport::Concern
  include StadiumAssociating

  included do
    validates :date, presence: true
    validates :race_number, presence: true, inclusion: { in: Race.numbers }
  end
end
