class Formation
  def initialize(candicate_pit_numbers_list)
    # HACK: 型宣言とかでうまく書けないものか(この場合数値の配列3つ持った2次元配列であることを想定している)
    # もっと言えば末端の要素である数値は1..6の範疇である必要もある
    raise ArgumentError, "the argument must be an array" unless candicate_pit_numbers_list.is_a?(Array)

    array_size = candicate_pit_numbers_list.size
    raise ArgumentError, "formation can receive three element array only (#{array_size})" unless array_size == 3

    unless candicate_pit_numbers_list.all? { |array| array.all? { |number| number.is_a?(Integer) } }
      raise ArgumentError, "the argument must be array of array which has only integer array"
    end

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
