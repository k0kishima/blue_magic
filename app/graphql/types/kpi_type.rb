module Types
  class KpiType < Types::BaseObject
    field :key, String, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :type, String, null: false
  end
end
