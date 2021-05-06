namespace :official_website do
  namespace :crawl do
    def official_website_version
      (ENV['USE_VERSION'].presence || Rails.application.config.x.official_website_proxy.latest_official_website_version).to_i
    end

    # e.g.
    # docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_day DATE='2021-04-30'
    desc 'crawl all data on specified date'
    task crawl_all_data_of_a_day: :environment do
      raise ArgumentError.new('need to turn on `Setting.crawling_enable` true to start the task') unless Setting.crawling_enable

      date = ENV.fetch('DATE').to_date
      sleep_second = ENV.fetch('INTERVAL', 1).to_i
      no_cache = ENV.fetch('NO_CACHE', false)

      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      if date == date.beginning_of_month
        puts "start to crawl events in current month"
        OfficialWebsite::CrawlEventsJob.perform_later(year: date.year, month: date.month, version: official_website_version)
      end

      puts "start to crawl motor renewals on #{date}"
      OfficialWebsite::CrawlMotorRenewalsJob.perform_later(date: date, version: official_website_version)

      puts 'start to crawl race informations'
      EventHolding.opened_on(date).each do |event_holding|
        puts "\tin stadium(tel_code: #{event_holding.stadium_tel_code})"

        Race.numbers.each do |race_number|
          puts "\t\tat #{race_number}R"
          sleep sleep_second

          page = OfficialWebsite::RaceInformationPage.new(
            version: official_website_version, no_cache: no_cache,
            race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
          )
          crawler = Crawler.new(page)
          crawler.crawl!
        end
      end

      puts 'start to schedule to crawl other data'
      OfficialWebsite::ScheduleRaceDataCrawlingJob.perform_later(date: date, version: official_website_version)

      puts 'jobs have been enqueued'
    end
  end
end
