class KpiFactory
  class << self
    def create!(hash:)
      Kpi.find_by!(attribute_name: hash.symbolize_keys.fetch(:attribute))
    end

    def create_recursively!(hash:)
      attribute_names = extract_hash_recursively!(hash: hash).map do |h|
        h.symbolize_keys.fetch(:attribute)
      rescue KeyError
        nil
      end.compact.uniq

      cache_key = ['kpi', Digest::MD5.hexdigest(attribute_names.sort.join('-'))].join(':')
      Rails.cache.fetch(cache_key, expires_in: 3.minutes) do
        Kpi.where(attribute_name: attribute_names)
      end
    end

    private

    def extract_hash_recursively!(hash:)
      if hash.keys.count == 1
        hashes = hash.values.first
        raise ArgumentError, "#{hashes} is not array" unless hashes.is_a?(Array)

        hashes.map do |h|
          h.keys.count == 1 ? extract_hash_recursively!(hash: h) : h
        end.flatten
      else
        hash
      end
    end
  end
end
