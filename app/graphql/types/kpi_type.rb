module Types
  class KpiType < Types::BaseObject
    field :entry_object_class_name, String, null: false
    field :key, String, null: false
    field :name, String, null: false
    field :description, String, null: true
  end
end
