class EstimateRaceSalesService
  MINIMUM = 4_000_000

  include ServiceBase

  def call
    # TODO: グレード、企画、祝日なども考慮して厳密に算出する
    MINIMUM * timeframe_coefficient * day_coefficient
  rescue
    # 算出エラーで予想処理を止める必要はないのでここにフォールバックして最小限の見積もりを返せばいい
    MINIMUM
  end

  private

  attr_accessor :betting_deadline_at

  def timeframe_coefficient
    case betting_deadline_at.hour
    when 13..17
      1.2
    when 18..21
      1.5
    else
      1
    end
  end

  def day_coefficient
    # 土日の場合
    if betting_deadline_at.wday.in?([0, 6])
      1.5
    else
      1
    end
  end
end
