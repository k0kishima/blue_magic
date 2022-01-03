class AnalysisFactory
  class << self
    def create!(entry_object:, select_condition:)
      kpis = KpiFactory.create_recursively!(hash: select_condition)
      kpis_indexed_by_own_key = kpis.map { |kpi| [kpi.key.to_sym, kpi] }.to_h

      analysis = {}

      extract_hash_recursively!(hash: select_condition).each do |hash|
        begin
          kpi_key = hash.symbolize_keys.fetch(:attribute).to_sym
        rescue KeyError => e
          next
        end

        entry_object_reader_name = hash.symbolize_keys.fetch(:item).to_sym
        kpi = kpis_indexed_by_own_key.fetch(kpi_key)

        kpi.entry_object = entry_object.try(entry_object_reader_name)
        analysis[entry_object_reader_name] ||= {}
        analysis[entry_object_reader_name][kpi.key] ||= kpi.value!
      end

      Hashie::Mash.new(analysis.merge(analysis.delete(:itself)))
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
