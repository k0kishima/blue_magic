module Types
  class QueryType < Types::BaseObject
    field :kpis, resolver: Resolvers::KpisResolver
    field :settings, resolver: Resolvers::SettingsResolver
  end
end
