require 'open-uri'

# NOTE:
# 公式サイトの知識(特定のコンテンツのURLやその構造など)はこのリポジトリでは持たない
# プロキシを介してアクセスする
# したがって、スクレイパーと違って公式サイトのバージョンごとにモデルを実装する必要がない
# 公式サイトの構造の関心はプロキシが持ってるので、ここでは単にバージョンをパラメータで切り替えてプロキシに投げるだけ
module OfficialWebsite
  class Page
    BASE_URL = Rails.application.config.x.official_website_proxy.base_url
    USE_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :version, :integer, default: USE_VERSION
    attribute :no_cache, :boolean, default: false

    def file
      URI.parse("#{BASE_URL}/file?#{query}", **headers).open
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
