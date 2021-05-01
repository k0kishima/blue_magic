namespace :official_website do
  namespace :data_import do
    def official_website_version
      (ENV['USE_VERSION'].presence || Rails.application.config.x.official_website_proxy.latest_official_website_version).to_i
    end

    # e.g.
    # docker-compose exec app bundle exec rake official_website:data_import:fetch_specified_contents_data_of_a_day DATE='2021-04-30' CONTENT_MODEL_NAME='OfficialWebsite::RaceResultPage' INTERVAL=0
    desc 'fetch specified contents on specified date'
    task fetch_specified_contents_data_of_a_day: :environment do
      content_model = ENV.fetch('CONTENT_MODEL_NAME').constantize
      sleep_second = ENV.fetch('INTERVAL', 1).to_i
      no_cache = ENV.fetch('NO_CACHE', false)
      date = ENV.fetch('DATE').to_date

      puts "start to fetch data of #{content_model} on #{date}"

      event_holdings = EventHolding.opened_on(date)
      pages = event_holdings.map do |event_holding|
        puts "\tin stadium(tel_code: #{event_holding.stadium_tel_code})"
        Race.numbers.map do |race_number|
          puts "\t\tat #{race_number}R"
          sleep sleep_second

          content_model.new(
            version: official_website_version, no_cache: no_cache,
            race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
          )
        end
      end.flatten

      available_scraper_classes = ScraperClassFactory.bulk_create!(pages.first, context: :single_page)
      available_scraper_classes.each do |scraper_class|
        ImportDataQueueFactory.create!(scraper_class, *pages)
      end
    end

    # e.g.
    # docker-compose exec app bundle exec rake official_website:data_import:fetch_all_data_of_a_day DATE='2021-04-30'
    desc 'fetch all data on specified date'
    task fetch_all_data_of_a_day: :environment do
      [
        OfficialWebsite::RaceInformationPage,
        OfficialWebsite::RaceExhibitionInformationPage,
        OfficialWebsite::RaceResultPage,
        OfficialWebsite::RaceOddsPage,
      ].each do |content_model|
        ENV['CONTENT_MODEL_NAME'] = content_model.name
        Rake::Task['official_website:data_import:fetch_specified_contents_data_of_a_day'].execute
      end
    end
  end
end
