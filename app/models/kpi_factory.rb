class KpiFactory
  class << self
    def create!(entry_object_class_name:, hash:)
      Kpi.find_by!(entry_object_class_name: entry_object_class_name,
                   attribute_name: hash.symbolize_keys.fetch(:attribute))
    end

    def create_recursively!(entry_object_class_name:, hash:)
      extract_hash_recursively!(entry_object_class_name: entry_object_class_name, hash: hash).map do |h|
        create!(entry_object_class_name: entry_object_class_name, hash: h)
      rescue KeyError
        nil
      end.compact.uniq
    end

    private

    def extract_hash_recursively!(entry_object_class_name:, hash:)
      if hash.keys.count == 1
        hashes = hash.values.first
        raise ArgumentError, "#{hashes} is not array" unless hashes.is_a?(Array)

        hashes.map do |h|
          h.keys.count == 1 ? extract_hash_recursively!(entry_object_class_name: entry_object_class_name, hash: h) : h
        end.flatten
      else
        hash
      end
    end
  end
end
