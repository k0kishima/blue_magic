namespace :once do
  namespace :official_website do
    desc 'create all race page caches in specified day'
    task create_all_race_page_caches_of_a_day: :environment do
      race_page_classes = [
        OfficialWebsite::RaceInformationPage,
        OfficialWebsite::RaceExhibitionInformationPage,
        OfficialWebsite::RaceResultPage,
        OfficialWebsite::RaceOddsPage,
      ]

      sleep_second = ENV.fetch('INTERVAL', 1).to_i
      date = ENV.fetch('DATE').to_date
      no_cache = ENV.fetch('NO_CACHE', true)

      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      puts "start to create caches of race pages on #{date}"

      EventHolding.opened_on(date).each do |event_holding|
        puts "\tin stadium(tel_code: #{event_holding.stadium_tel_code})"

        Race.numbers.each do |race_number|
          puts "\t\tat #{race_number}R"

          race_page_classes.each do |race_page_class|
            puts "\t\t\tfor #{race_page_class.name}"

            Retryable.retryable(tries: 3, sleep: 10, on: [Net::OpenTimeout, OpenURI::HTTPError]) do
              page = race_page_class.new(
                version: official_website_version, no_cache: no_cache,
                race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
              )
              page.file.close
            end

            sleep sleep_second
          end
        end
      end
    end
  end
end
