module OfficialWebsite::V1707
  class RaceEntriesScraper
    NO_DATA_PLACEHOLDER = '-'
    def initialize(file)
      @file = file
    end

    def scrape!
      data = []

      racer_rows.each.with_index(1) do |row, pit_number|
        @current_row = row
        racer_names = racer_name.split(/[　]+/).reverse
        data << {
          racer_registration_number: racer_registration_number,
          racer_first_name: racer_names.first,
          racer_last_name: racer_names.last,
          racer_rank: rank,
          pit_number: pit_number,
          motor_number: motor_number,
          quinella_rate_of_motor: quinella_rate_of_motor,
          trio_rate_of_motor: trio_rate_of_motor,
          boat_number: boat_number,
          quinella_rate_of_boat: quinella_rate_of_boat,
          trio_rate_of_boat: trio_rate_of_boat,
          whole_country_winning_rate: whole_country_winning_rate,
          local_winning_rate: local_winning_rate,
          whole_country_quinella_rate_of_racer: whole_country_quinella_rate_of_racer,
          whole_country_trio_rate_of_racer: whole_country_trio_rate_of_racer,
          local_quinella_rate_of_racer: local_quinella_rate_of_racer,
          local_trio_rate_of_racer: local_trio_rate_of_racer,
          is_absent: is_absent,
        }
      end

      data
    ensure
      file.close
    end

    private

    attr_reader :file, :current_row

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def race_entry_table
      @race_entry_table ||= html.search('.table1').last
    end

    def racer_rows
      @racer_rows ||= race_entry_table.search('tbody')
    end

    def racer_photo_path
      current_row.search('tr').first.search('td')[1].search('img').attribute('src').value
    end

    def racer_registration_number
      racer_photo_path.scan(/\/(\d+)\.jpe?g$/).flatten.first.to_i
    end

    def racer_name
      current_row.search('tr').first.search('td')[2].search('div a').text
    end

    def rank
      current_row.search('tr').first.search('td')[2].search('span').text
    end

    def motor_number
      current_row.search('tr').first.search('td')[6].children.first.text.scan(/(\d+)/).flatten.first.to_i
    end

    def quinella_rate_of_motor
      current_row.search('tr').first.search('td')[6].children[2].text.strip.to_f
    end

    def trio_rate_of_motor
      text = current_row.search('tr').first.search('td')[6].children[4].text.strip
      text == NO_DATA_PLACEHOLDER ? nil : text.to_f
    end

    def boat_number
      current_row.search('tr').first.search('td')[7].children.first.text.scan(/(\d+)/).flatten.first.to_i
    end

    def quinella_rate_of_boat
      current_row.search('tr').first.search('td')[7].children[2].text.strip.to_f
    end

    def trio_rate_of_boat
      text = current_row.search('tr').first.search('td')[7].children[4].text.strip
      text == NO_DATA_PLACEHOLDER ? nil : text.to_f
    end

    def whole_country_winning_rate
      current_row.search('tr').first.search('td')[4].children.first.text.strip.to_f
    end

    def local_winning_rate
      current_row.search('tr').first.search('td')[5].children.first.text.strip.to_f
    end

    def whole_country_quinella_rate_of_racer
      current_row.search('tr').first.search('td')[4].children[2].text.strip.to_f
    end

    def whole_country_trio_rate_of_racer
      current_row.search('tr').first.search('td')[4].children.last.text.strip.to_f
    end

    def local_quinella_rate_of_racer
      current_row.search('tr').first.search('td')[5].children[2].text.strip.to_f
    end

    def local_trio_rate_of_racer
      current_row.search('tr').first.search('td')[5].children.last.text.strip.to_f
    end

    def is_absent
      current_row.attribute('class').value.include?('is-miss')
    end
  end
end
