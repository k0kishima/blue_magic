module Resolvers
  class SettingsResolver < Resolvers::BaseResolver
    description 'Fetch settings list'

    type [Types::SettingType], null: false

    def resolve
      Setting.all
    end
  end
end
