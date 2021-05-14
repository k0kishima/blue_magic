class Kpi::Aggregation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :kpi
  attribute :value
  attribute :aggregate_starts_on, :date
  attribute :aggregate_ends_on, :date
end
