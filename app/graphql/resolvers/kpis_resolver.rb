module Resolvers
  class KpisResolver < Resolvers::BaseResolver
    description 'Fetch kpi list'

    type [Types::KpiType], null: false

    def resolve
      Kpi.all
    end
  end
end
