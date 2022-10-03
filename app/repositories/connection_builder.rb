module ConnectionBuilder
  class << self
    def build(url, options = {})
      Faraday::Connection.new(url: url, ssl: false) do |conn|
        conn.request options[:request_content_type] || :url_encoded
        conn.response :json, content_type: /\bjson$/
        conn.use :instrumentation
        conn.adapter options[:adapter] || Faraday.default_adapter
      end
    end
  end
end
