class BettingStrategy::Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :recommend_odds
  validates :recommend_odds, presence: true
  validate :odds_must_be_before_betting

  def vote!
    # TODO: テレボート経由で実際に投票する処理を実装
    raise NotImplementedError
  end

  private

  def odds_must_be_before_betting
    return if recommend_odds.blank?
    return if recommend_odds.joins(:betting).blank?

    errors.add(:recommend_odds, 'must be before betting')
  end
end
