module Resolvers
  class KpisResolver < Resolvers::BaseResolver
    description 'Fetch kpi list'

    type [Types::KpiType], null: false

    argument :keyword, String, required: false

    def resolve(keyword: nil)
      kpis = Kpi::Base.all
      kpis = kpis.select { |kpi| kpi.name.include?(keyword) } if keyword.present?
      kpis
    end
  end
end
