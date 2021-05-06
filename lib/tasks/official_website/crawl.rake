namespace :official_website do
  namespace :crawl do
    def official_website_version
      latest_version = Rails.application.config.x.official_website_proxy.latest_official_website_version
      (ENV['USE_VERSION'].presence || latest_version).to_i
    end

    # e.g.
    # docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_month YEAR=2021 MONTH=4
    desc 'crawl all data on specified month'
    task crawl_all_data_of_a_month: :environment do
      year = (ENV['YEAR'].presence || Time.zone.today.year).to_i
      month = (ENV['MONTH'].presence || Time.zone.today.month).to_i
      day = (ENV['DAY_OFFSET'].presence || 1).to_i
      date = Date.new(year, month, day)

      (date..date.end_of_month).each do |crawl_date|
        break if crawl_date > Date.today

        ENV['DATE'] = crawl_date.to_s
        Rake::Task['official_website:crawl:crawl_all_data_of_a_day'].execute
      end

      slack_client = Slack::Web::Client.new
      slack_client.chat_postMessage(channel: '001_crawler_info', text: "monthly crawling have done (#{year}/#{month})")
    end

    # e.g.
    # docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_day DATE='2021-04-30'
    desc 'crawl all data on specified date'
    task crawl_all_data_of_a_day: :environment do
      unless Setting.crawling_enable
        raise ArgumentError.new('need to turn on `Setting.crawling_enable` true to start the task')
      end

      date = ENV.fetch('DATE').to_date
      sleep_second = ENV.fetch('INTERVAL', 1).to_i
      no_cache = ENV.fetch('NO_CACHE', false)

      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      if date == date.beginning_of_month
        puts "start to enqueue crawl events job in current month"
        OfficialWebsite::CrawlEventsJob.perform_later(year: date.year, month: date.month,
                                                      version: official_website_version)
      end

      puts "start to enqueue crawl motor renewals job on #{date}"
      OfficialWebsite::CrawlMotorRenewalsJob.perform_later(date: date, version: official_website_version)

      puts 'start to enqueue crawl race data jobs'
      EventHolding.opened_on(date).each do |event_holding|
        puts "\tin stadium(tel_code: #{event_holding.stadium_tel_code})"

        Race.numbers.each do |race_number|
          puts "\t\tat #{race_number}R"
          sleep sleep_second

          [
            OfficialWebsite::CrawlRaceInformationsJob,
            OfficialWebsite::CrawlRaceExhibitionInformationsJob,
            OfficialWebsite::CrawlRaceResultsJob,
            OfficialWebsite::CrawlOddsJob,
            OfficialWebsite::CrawlBoatSettingsJob,
          ].each do |crawl_data_job|
            crawl_data_job.perform_later(
              version: official_website_version,
              race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
            )
          end
        end
      end

      puts 'jobs have been enqueued'
    end
  end
end
