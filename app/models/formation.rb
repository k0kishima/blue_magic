class Formation
  def initialize(candicate_pit_numbers_list)
    @candicate_pit_numbers_list = candicate_pit_numbers_list
  end

  def betting_numbers
    candicate_pit_numbers_list
      .inject(&:product)
      .map(&:flatten)
      .select { |numbers| numbers.uniq.count == 3 }  # HACK: 3連単以外に対応必要になったときに修正
      .map(&:join)
      .map(&:to_i)
  end

  private

  attr_reader :candicate_pit_numbers_list
end
