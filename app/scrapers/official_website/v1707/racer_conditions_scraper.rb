module OfficialWebsite
  class V1707::RacerConditionsScraper < Scraper
    # HACK: 欲しいのは date だけなんだけど stadium_tel_code や race_number もついてきてる
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable

    def scrape!
      validate!

      data = []

      exhibition_rows.each.with_index(1) do |row, pit_number|
        next if absence?(row)

        data << {
          date: date,
          pit_number: pit_number,
          racer_registration_number: racer_registration_number(row),
          weight: weight(row),
          adjust: adjust(row),
        }
      end

      self.cache = data

      data
    end

    private

    attr_reader :file

    def html
      @html ||= -> do
        file.rewind
        Nokogiri::HTML.parse(file.read)
      end.call
    end

    def exhibition_rows
      @exhibition_rows ||= html.search('.table1')[1].search('tbody')
    end

    def weight(exhibition_row)
      exhibition_row.search('td')[3].text.to_f
    end

    def absence?(exhibition_row)
      exhibition_row.attribute('class').value.split(' ').include?('is-miss')
    end

    def adjust(exhibition_row)
      exhibition_row.search('td')[12].text.to_f
    end

    def racer_registration_number(exhibition_row)
      exhibition_row.search('td')[2].search('a').attribute('href').value.scan(/toban=(\d{4})$/).flatten.first.to_i
    end

    def pit_number(slit_row)
      slit_row.search('span')[0].text.to_i rescue nil
    end
  end
end
