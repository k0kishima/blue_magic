class OperandProcessorFactory
  def self.create!(hash)
    hash = hash.symbolize_keys
    item = begin
      hash.fetch(:item)
    rescue KeyError
      BinaryExpressionFactory.create!(hash)
    end

    if item.to_sym == :literal
      value = hash.fetch(:value)
      ->(_) { value }
    else
      attribute_name = hash.fetch(:attribute)
      ->(object) { object.try(item).send(attribute_name) }
    end
  end
end
