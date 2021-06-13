module Mutations
  class UpdateSetting < BaseMutation
    argument :var, String, required: true, description: 'Setting item name'
    argument :value, Boolean, required: true, description: 'Setting value'

    field :setting, Types::SettingType, null: false

    def resolve(var:, value:)
      setting = Setting.find_by!(var: var)
      setting.update(value: value)
      { setting: setting }
    end
  end
end
