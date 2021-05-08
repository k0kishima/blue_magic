class DisqualificationFactory
  def self.create!(mark)
    case mark
    when '転'
      :capsize
    when '落'
      :fall
    when '沈'
      :sinking
    when '妨'
      :violation
    when '失'
      :disqualification_after_start
    when 'エ'
      :engine_stop
    when '不'
      :unfinished
    when '返'
      :repayment_other_than_flying_and_lateness
    when 'Ｆ'
      :flying
    when 'Ｌ'
      :lateness
    when '欠'
      :absent
    when '＿'
      # NOTE: これは失格ではない
      # レース不成立で着順が定まらなかったケース
      # 例)
      # http://boatrace.jp/owpc/pc/race/raceresult?rno=11&jcd=23&hd=20170429
      # TODO:
      # V1707特有の表記法と思われるので、公式サイトがリニューアルされたら適宜修正
      nil
    else
      raise NotImplementedError
    end
  end
end
