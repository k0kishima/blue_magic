class Kpi::Factory
  class << self
    def create!(hash)
      operand = hash.symbolize_keys.fetch(:item)
      key = hash.symbolize_keys.fetch(:attribute)

      kpi_class =
        Kpi::Base.applicable
                 .select { |applicable_kpi_class| applicable_kpi_class.operand.to_sym == operand.to_sym }
                 .find { |kpi_class_for_operand| kpi_class_for_operand.key.to_sym == key.to_sym }

      raise ArgumentError, "kpi class cannot create from #{hash}" if kpi_class.blank?

      kpi = kpi_class.new

      # この処理がない場合invalidになるKPIオブジェクトもあるが、ここではインスタンスを生成するまでが責務なのでvalidなものを生成するところまでの責任は負わない
      attribute_name, value = hash.symbolize_keys.fetch(:modifier, [])
      kpi.try!("#{attribute_name}=", value) if attribute_name.present?

      kpi
    end

    def create_recursively!(hash)
      extract_hash_recursively!(hash).uniq.map do |h|
        create!(h)
      rescue KeyError
        nil
      end.compact
    end

    private

    def extract_hash_recursively!(hash)
      if hash.keys.count == 1
        hashes = hash.values.first
        raise ArgumentError, "#{hashes} is not array" unless hashes.is_a?(Array)

        hashes.map do |h|
          h.keys.count == 1 ? extract_hash_recursively!(h) : h
        end.flatten
      else
        hash
      end
    end
  end
end
