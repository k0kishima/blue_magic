class BettingStrategy::Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :recommend_odds
  validates :recommend_odds, presence: true
  validate :odds_must_be_before_betting

  def vote!(bettings)
    return false if !Setting.voting_enable

    return false if bettings.blank?

    representative_value = bettings.first
    stadium_tel_code, race_number, date = representative_value.attributes.symbolize_keys.values_at(:stadium_tel_code,
                                                                                                   :race_number, :date)

    return false if date != Date.today

    # note: ストラテジーによっては買い目の重複を省くなどのフィルタリングをしているのでそういった処理が施された bettings の方を用いる
    odds = bettings.map { |betting| { number: betting.betting_number, quantity: betting.purchase_quantity } }

    # todo: votes! にメソッド名を変更する
    TicketRepository.votes(stadium_tel_code: stadium_tel_code, race_number: race_number, odds: odds)

    NotifyVotingService.call(stadium_tel_code: stadium_tel_code, race_number: race_number, odds: odds)

    true
  end

  private

  def odds_must_be_before_betting
    return if recommend_odds.blank?
    return if recommend_odds.joins(:betting).blank?

    errors.add(:recommend_odds, 'must be before betting')
  end
end
