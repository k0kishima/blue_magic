# NOTE:
# 公式サイトの知識(特定のコンテンツのURLやその構造など)はこのリポジトリでは持たない
# プロキシを介してアクセスする
# したがって、スクレイパーと違って公式サイトのバージョンごとにモデルを実装する必要がない
# 公式サイトの構造の関心はプロキシが持ってるので、ここでは単にバージョンをパラメータで切り替えてプロキシに投げるだけ
# FIXME: 継承をやめる（リスコフの置換原則に違反してるため）
module OfficialWebsite
  class Page
    BASE_URL = Rails.application.config.x.official_website_proxy.base_url
    DEFAULT_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :version, :integer, default: DEFAULT_VERSION
    attribute :no_cache, :boolean, default: false

    def uri
      "#{BASE_URL}/file?#{query}"
    end

    def file
      @file ||= Tempfile.open(SecureRandom.uuid) do |f|
        f.puts(HTTParty.get(uri, headers: headers).body)
        f
      end
    end

    def origin_redirection_url
      "#{BASE_URL}/redirection?#{query}"
    end

    private

    def query
      params.merge({
                     version: version,
                     page_type: self.class.name.underscore.split('/').last,
                   }).to_query
    end

    def params
      raise NotImplementedError
    end

    def headers
      h = {}
      h['Cache-Control'] = 'no-cache' if no_cache
      h
    end
  end
end
