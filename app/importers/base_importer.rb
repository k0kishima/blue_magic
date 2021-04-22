class BaseImporter
  def import!(parsed_attributes)
    resources = parsed_attributes.map { |attributes| model_class.new(attributes) }
    model_class.import!(resources, all_or_none: true, on_duplicate_key_update: on_duplicate_key_update)
  end

  private

  def model_class
    raise NotImplementedError
  end
end
