module OfficialWebsite
  class V1707::MotorMaintenancesScraper < Scraper
    PARTS_COUNT_DELIMITER = '×'

    def scrape!
      validate!

      data = []

      exhibition_rows.each.with_index(1) do |row, pit_number|
        element = {
          pit_number: pit_number,
          racer_registration_number: racer_registration_number(row),
        }

        parts_exchanges = parts_lists(row).map do |li_element|
          {
            parts_name: parts_name(li_element),
            count: parts_count(li_element),
          }
        end

        element[:parts_exchanges] = parts_exchanges.present? ? parts_exchanges.to_json : nil

        data << element
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

    def parts_lists(exhibition_row)
      exhibition_row.search('td')[7].search('li')
    end

    def parts_count(li_element)
      part_name_and_count = li_element.text.split(PARTS_COUNT_DELIMITER)
      if part_name_and_count.count == 1
        1
      else
        part_name_and_count.last.tr('０-９', '0-9').to_i
      end
    end

    def parts_name(li_element)
      li_element.text.split(PARTS_COUNT_DELIMITER).first.gsub(' ', '')
    end
  end
end
