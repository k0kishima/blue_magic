module OfficialWebsite
  class V1707::RaceExhibitionRecordsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable

    def scrape!
      validate!

      data = []

      exhibition_rows.each.with_index(1) do |exhibition_row, pit_number|
        next if absence?(exhibition_row)

        data << {
          date: date,
          stadium_tel_code: stadium_tel_code,
          race_number: race_number,
          pit_number: pit_number,
          racer_registration_number: racer_registration_number(exhibition_row),
          exhibition_time: exhibition_time(exhibition_row),
        }

        sorted_exhibition_times = data.map { |element| element[:exhibition_time] }.sort
        data.each do |element|
          element[:exhibition_time_order] = sorted_exhibition_times.index(element[:exhibition_time])&.next
        end

        slit_rows.each.with_index(1) do |slit_row, start_course|
          next unless element = data.find { |e| e[:pit_number] == pit_number(slit_row) }

          element[:start_course] = start_course
          element[:start_time] = formatted_start_time(slit_row)
          element[:is_flying] = flying?(slit_row)
        end
      end

      self.cache = data

      data
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def exhibition_rows
      @exhibition_rows ||= html.search('.table1')[1].search('tbody')
    end

    def slit_rows
      @slit_rows ||= html.search('.table1')[2].search('tbody tr')
    end

    def absence?(exhibition_row)
      exhibition_row.attribute('class').value.split(' ').include?('is-miss')
    end

    def racer_registration_number(exhibition_row)
      exhibition_row.search('td')[2].search('a').attribute('href').value.scan(/toban=(\d{4})$/).flatten.first.to_i
    end

    def pit_number(slit_row)
      slit_row.search('span')[0].text.to_i rescue nil
    end

    def exhibition_time(exhibition_row)
      exhibition_row.search('td')[4].text.to_f
    end

    def new_propeller?(exhibition_row)
      propeller(exhibition_row) == self.class::NEW_PROPELLER_MARK
    end

    def flying?(slit_row)
      html_classes = start_time_element(slit_row).attribute('class').value.split(' ')
      html_classes.include?('is-fBold')
    end

    def start_time_element(slit_row)
      slit_row.search('span').last
    end

    def start_time_text(slit_row)
      start_time_element(slit_row).text
    end

    def formatted_start_time(slit_row)
      text = start_time_text(slit_row)
      text.gsub!('F', '') if flying?(slit_row)
      text.to_f
    end
  end
end
