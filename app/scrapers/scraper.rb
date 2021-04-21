class Scraper
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include Publishable

  attribute :file
  validates :file, presence: true

  attr_reader :cache
  attr_accessor :file

  def cache=(data)
    @cache = data
    notify_observers
  end
end
