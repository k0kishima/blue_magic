module OfficialWebsite
  class V1707::BoatSettingsScraper < Scraper
    NEW_PROPELLER_MARK = '新'

    def scrape!
      validate!

      data = []

      exhibition_rows.each.with_index(1) do |row, pit_number|
        data << {
          pit_number: pit_number,
          racer_registration_number: racer_registration_number(row),
          tilt: tilt(row),
          is_new_propeller: new_propeller?(row),
        }
      end

      if data.all? { |attribute| attribute[:tilt].nil? }
        raise ::DataNotFound
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

    def absence?(exhibition_row)
      exhibition_row.attribute('class').value.split(' ').include?('is-miss')
    end

    def racer_registration_number(exhibition_row)
      exhibition_row.search('td')[2].search('a').attribute('href').value.scan(/toban=(\d{4})$/).flatten.first.to_i
    end

    def pit_number(slit_row)
      slit_row.search('span')[0].text.to_i rescue nil
    end

    def tilt(exhibition_row)
      value = exhibition_row.search('td')[5].text
      value.blank? ? nil : value.to_f
    end

    def propeller(exhibition_row)
      exhibition_row.search('td')[6].text
    end

    def new_propeller?(exhibition_row)
      propeller(exhibition_row) == self.class::NEW_PROPELLER_MARK
    end
  end
end
