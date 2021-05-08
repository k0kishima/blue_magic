class ReduceOddsMethod
  module ID
    TAKE_THE_FIRST = 1
    TAKE_ALL_WITHOUT_DUPLICATES = 2
    TAKE_ALL = 3
  end

  def self.all
    ID.constants.map { |constant_name| ID.const_get(constant_name) }.sort
  end
end
