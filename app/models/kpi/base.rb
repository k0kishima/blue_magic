class Kpi::Base
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key, :string
  attribute :name, :string
  attribute :description, :string

  class << self
    def all
      # HACK: これやらないと未使用のクラスが読み込まれる機会がないためObjectSpaceにサブクラスが入らなくて .subclasses や .descendants の返り値が空になってしまう
      # Rails.application.eager_load! で関係ないファイル全部読むよりはマシではあるのでワークアラウンドとして使用
      Dir[Rails.root.join('app', 'models', 'kpi', '**', '*.rb')].each { |f| require f }
      kpis = Kpi::RaceEntry::Base.descendants
      kpis.map(&:instance)
    end
  end

  def subject
    raise NotImplementedError
  end
end
