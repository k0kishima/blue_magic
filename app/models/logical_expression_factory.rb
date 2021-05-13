class LogicalExpressionFactory
  ENABLE_OPERATORS = %w[and or]

  def self.create!(hash)
    raise ArgumentError, "#{hash.keys} are invalid." unless hash.keys.count == 1
    raise ArgumentError unless hash.values.count == 1

    operator = hash.keys.first.to_s
    raise ArgumentError, "#{operator} is an invalid operator" unless operator.in?(ENABLE_OPERATORS)

    operands = hash.values.first
    raise ArgumentError, "#{operands} is not array" unless operands.is_a?(Array)

    lambda do |object|
      expressions = operands.map do |operand|
        create!(operand)
      rescue StandardError
        BinaryExpressionFactory.create!(operand)
      end

      expressions.map { |expression| expression.call(object) }.try(
        case operator
        when 'and'
          :all?
        when 'or'
          :any?
        end
      )
    end
  end
end
