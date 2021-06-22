class BinaryExpressionFactory
  def self.create!(hash)
    raise ArgumentError unless hash.keys.count == 1
    raise ArgumentError unless hash.values.first.count == 2

    operator = hash.keys.first
    left_operand_processor, right_operand_processor = hash.values.first.map do |h|
      begin
        OperandProcessorFactory.create!(h)
      rescue StandardError
        self.create!(h)
      end
    end

    ->(object) do
      # 今期F回数などのKPI値が入る
      value_to_be_compared = left_operand_processor.call(object)

      if value_to_be_compared.nil?
        raise DataNotFound, "cannot operate #{hash} because of nil"
      end

      # それを閾値と比較する
      # 以下だと閾値は1で、これをoperatorである >= で比較している
      # {">="=>[{"item"=>"pit_number_1", "attribute"=>"flying_count_in_current_rating_term"}, {"item"=>"literal", "value"=>1}]}
      value_to_be_compared.try(operator, right_operand_processor.call(object))
    end
  end
end
