namespace :kpi do
  # e.g. docker-compose exec app bundle exec rake kpi:update KPI_ID=81 
  desc 'enque bet jobs '
  task update: :environment do
    kpi = Kpi.find(ENV['KPI_ID'].to_i)

    puts "Start to update '#{kpi.name}'"

    unless kpi.entry_object_class_name == 'RaceEntry'
      raise NotImplementedError
    end

    # note:
    # 謎に `Mysql2::Error: Unknown column 'race_analysis_caches.["stadium_tel_code", "date", "race_number"]' in 'order clause'` が
    # 1回だけ発生する（リトライしたら起こらなくなる）問題へのワークアラウンド
    RaceAnalysisCache.joins(:race).last rescue nil

    BATCH_SIZE = 500
    updated_count = 0
    RaceAnalysisCache.joins(:race).find_in_batches(batch_size: BATCH_SIZE) do |caches|
      caches.each do |cache|
        begin
          data = cache.data
          Pit::NUMBER_RANGE.each do |pit_number|
            data["pit_number_#{pit_number}"][kpi.attribute_name] = cache.race.try("pit_number_#{pit_number}").try(kpi.attribute_name)
          end
          cache.data = data
          cache.save
        rescue => e
          Rails.logger.error e.message
        end
      end

      updated_count += BATCH_SIZE
      puts "processed: #{updated_count}"
      sleep 1.second 
    end

    puts 'updated.'
  end
end
