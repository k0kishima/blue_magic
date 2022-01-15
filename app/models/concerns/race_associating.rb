# TODO: 名前変更
# HasRaceAssociating みたいな方がいいと思う
# そもそも Associating って書いてあるのに belongs_to などの関連がないので名前と実態に乖離がある
module RaceAssociating
  extend ActiveSupport::Concern
  include StadiumAssociating

  included do
    validates :date, presence: true
    validates :race_number, presence: true, inclusion: { in: Race.numbers }
  end
end
