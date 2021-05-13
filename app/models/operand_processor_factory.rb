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
      return ->(_) { value }
    end

    attr = hash.fetch(:attr)
    modifier = hash.fetch(:modifier, nil)

    # NOTE: try だと method_missing が動作しないので send を使用
    if modifier.blank?
      ->(object) { object.try(item).send(attr) }
    else
      lambda do |object|
        modifier_attr, modifier_value = modifier
        entity = object.try(item).find { |e| e.send(modifier_attr) == modifier_value }
        entity.send(attr)
      end
    end
  end
end
