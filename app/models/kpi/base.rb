class Kpi::Base
  include Singleton
  include ActiveModel::Model
  include ActiveModel::Attributes

  class << self
    def applicable
      # HACK: これやらないと未使用のクラスが読み込まれる機会がないためObjectSpaceにサブクラスが入らなくて .subclasses や .descendants の返り値が空になってしまう
      # Rails.application.eager_load! で関係ないファイル全部読むよりはマシではあるのでワークアラウンドとして使用
      Dir[Rails.root.join('app', 'models', 'kpi', '**', '*.rb')].each { |f| require f }
      Kpi::Stadium::WinningTrickKpi.descendants +
        Kpi::RaceEntry::WinningTrickKpi.descendants +
        Kpi::RaceEntry::AssistTrickKpi.descendants
    end
  end

  def key
    raise NotImplementedError
  end

  def name
    raise NotImplementedError
  end

  def description
    raise NotImplementedError
  end

  def subject
    raise NotImplementedError
  end
end
