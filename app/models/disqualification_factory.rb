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
      nil
    else
      raise NotImplementedError
    end
  end
end
