module Analysis
  class RaceFactory
    def self.create!(race, *kpis)
      raise ArgumentError, "A canceled race cannot analysis" if race.canceled?

      kpis.each { |kpi| kpi.source = race }

      # todo: 3セットの和が引数と一致するかを確かめたい
      race_kpis = kpis.select { |kpi| kpi.type == Race }
      stadium_kpis = kpis.select { |kpi| kpi.type == Stadium }
      race_entry_kpis = kpis.select { |kpi| kpi.type == RaceEntry }

      # 基本的な情報はKPIとして指定されていなくてもデフォルトで持つ
      race_analysis = race.attributes.slice(*Race.primary_keys)
      race_analysis[:race_entries] = race.race_entries.map { |race_entry|
        race_entry.attributes.symbolize_keys.slice(:pit_number)
      }

      race_analysis.merge(race_kpis.map { |kpi| [kpi.key, kpi.value!] }.to_h)

      race_analysis[:stadium] = stadium_kpis.map { |kpi| [kpi.key, kpi.value!] }.to_h

      race_entry_kpis.each do |kpi|
        race_analysis[:race_entries]
          .find { |race_entry| race_entry.fetch(:pit_number) == kpi.pit_number }
          .merge!({ kpi.key => kpi.value! })
      end

      Hashie::Mash.new(race_analysis)
    end
  end
end
