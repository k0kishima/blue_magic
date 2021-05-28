module KpiCalculator
  class AttributionalCalculator
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :object
    attribute :attribute_name
    validates :object, presence: true
    validates :attribute_name, presence: true

    def calculate!
      validate!
      object.try!(attribute_name)
    end
  end
end
