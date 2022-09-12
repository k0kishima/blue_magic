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
      ->(object) do
        if object.try(item).respond_to?(attribute_name)
          object.try(item).send(attribute_name)
        else
          Rails.application.config.betting_logger.info("#{attribute_name} is an invalid kpi".red)
        end
      end
    end
  end
end
