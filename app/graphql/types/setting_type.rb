module Types
  class SettingType < Types::BaseObject
    field :var, String, null: false
    field :value, Boolean, null: false
  end
end
