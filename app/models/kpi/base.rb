class Kpi::Base
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key, :string
  attribute :name, :string
  attribute :description, :string
end
