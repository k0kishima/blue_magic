class KpiFactory
  class << self
    def create!(hash:)
      Kpi.find_by!(attribute_name: hash.symbolize_keys.fetch(:attribute))
    end

    def create_recursively!(hash:)
      extract_hash_recursively!(hash: hash).map do |h|
        create!(hash: h)
      rescue KeyError
        nil
      end.compact.uniq
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
