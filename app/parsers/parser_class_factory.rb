require 'csv'

# TODO: バージョン追加された時点で修正する
class ParserClassFactory
  class << self
    def bulk_create(csv)
      csv = CSV.read(csv)

      # HACK: これやらないと未使用のクラスが読み込まれる機会がないためObjectSpaceにサブクラスが入らなくて .subclasses や .descendants の返り値が空になってしまう
      # Rails.application.eager_load! で関係ないファイル全部読むよりはマシではあるのでワークアラウンドとして使用
      Dir[Rails.root.join('app', 'parsers', '*.rb')].each { |f| require f }
  
      header = csv.first.map(&:to_sym)
      BaseParser.descendants.select do |parser_class|
        parser_class::HEADER_KEYS == header
      end
    end
  end
end
