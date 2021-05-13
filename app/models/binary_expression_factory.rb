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

    ->(object) { left_operand_processor.call(object).try(operator, right_operand_processor.call(object)) }
  end
end
