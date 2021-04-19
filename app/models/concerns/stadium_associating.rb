module StadiumAssociating
  extend ActiveSupport::Concern

  included do
    belongs_to :stadium, foreign_key: :stadium_tel_code, primary_key: :tel_code
    validates :stadium_tel_code, presence: true, inclusion: { in: Stadium::TELCODE_RANGE }
  end
end
