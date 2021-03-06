require 'open-uri'

# NOTE:
# 公式サイトの知識(特定のコンテンツのURLやその構造など)はこのリポジトリでは持たない
# プロキシを介してアクセスする
# したがって、スクレイパーと違って公式サイトのバージョンごとにモデルを実装する必要がない
# 公式サイトの構造の関心はプロキシが持ってるので、ここでは単にバージョンをパラメータで切り替えてプロキシに投げるだけ
module ThroughOfficialWebsiteProxy
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :version, :integer,
              default: Rails.application.config.x.official_website_proxy.latest_official_website_version

    def uri
      "#{proxy_base_url}/file?#{query}"
    end

    def file
      @file ||= URI.open(uri)
    end

    def origin_redirection_url
      "#{proxy_base_url}/redirection?#{query}"
    end

    def reload!
      headers = { 'Cache-Control' => 'no-cache' }
      @file = URI.open(uri, **headers)
    end

    private

    def proxy_base_url
      Rails.application.config.x.official_website_proxy.base_url
    end

    def query
      params.merge({
                     version: version,
                     page_type: self.class.name.underscore.split('/').last,
                   }).to_query
    end

    def params
      raise NotImplementedError
    end
  end
end
