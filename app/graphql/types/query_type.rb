module Types
  class QueryType < Types::BaseObject
    field :kpis, resolver: Resolvers::KpisResolver
  end
end
