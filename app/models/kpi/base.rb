class Kpi::Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :source
  validates :source, presence: true
  validate :source_must_be_a_race

  class << self
    def applicable
      # HACK: これやらないと未使用のクラスが読み込まれる機会がないためObjectSpaceにサブクラスが入らなくて .subclasses や .descendants の返り値が空になってしまう
      # Rails.application.eager_load! で関係ないファイル全部読むよりはマシではあるのでワークアラウンドとして使用
      Dir[Rails.root.join('app', 'models', 'kpi', '**', '*.rb')].each { |f| require f }
      Kpi::Stadium::WinningTrickKpi.descendants +
        Kpi::RaceEntry::WinningTrickKpi.descendants +
        Kpi::RaceEntry::AssistTrickKpi.descendants
    end

    def key
      name.split('::').last.underscore
    end
  end
  delegate :key, to: :class

  def name
    raise NotImplementedError
  end

  def description
    raise NotImplementedError
  end

  def subject
    raise NotImplementedError
  end

  def aggregation_starts_on
    raise NotImplementedError
  end

  def aggregation_ends_on
    raise NotImplementedError
  end

  def offset_date
    source.date
  end

  def source_must_be_a_race
    return if source.blank?
    return if source.is_a?(Race)

    errors.add(:source, 'source must be a race object.')
  end
end
