module Types
  class MutationType < Types::BaseObject
    field :update_setting, mutation: Mutations::UpdateSetting, null: true, description: 'update the setting'
  end
end
