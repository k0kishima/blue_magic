class BaseImporter
  include ScrapingSubscribable

  def import!(csv)
    parsed_attributes = parser_class.new(csv).parse!
    resources = parsed_attributes.map{|attributes| model_class.new(attributes) }
    model_class.import!(resources, all_or_none: true)
  end

  private

  def parser_class
    raise NotImplementedError
  end

  def model_class
    raise NotImplementedError
  end
end

