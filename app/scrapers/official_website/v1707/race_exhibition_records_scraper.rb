module OfficialWebsite
  class V1707::RaceExhibitionRecordsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable

    LATENESS_MARK = 'L'

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
          start_course: nil,
          start_time: nil,
          is_flying: nil,
          is_lateness: nil,
        }
      end

      sorted_exhibition_times = data.map { |element| element[:exhibition_time] }.sort
      data.each do |element|
        element[:exhibition_time_order] = sorted_exhibition_times.index(element[:exhibition_time])&.next
      end

      slit_rows.each.with_index(1) do |slit_row, start_course|
        next unless element = data.find { |e| e[:pit_number] == pit_number(slit_row) }

        element[:is_lateness] = lateness?(slit_row)
        next if element[:is_lateness]

        element[:start_course] = start_course
        element[:start_time] = formatted_start_time(slit_row)
        element[:is_flying] = flying?(slit_row)
      end

      if data.all? { |attribute| attribute[:start_course].nil? }
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
      # 以下のようにシンプルに取得したいがこれだと出遅れに対応できないので画像から割り出す
      # slit_row.search('span')[0].text.to_i rescue nil
      #
      # 出遅れが発生した展示
      # http://boatrace.jp/owpc/pc/race/beforeinfo?rno=2&jcd=17&hd=20170511
      slit_row.search('img')&.attr('src')&.value&.scan(/_([1-6]{1}).png\z/)&.flatten&.first&.to_i
    end

    def exhibition_time(exhibition_row)
      exhibition_row.search('td')[4].text.to_f
    end

    def flying?(slit_row)
      html_classes = start_time_element(slit_row).attribute('class').value.split(' ')
      html_classes.include?('is-fBold')
    end

    def lateness?(slit_row)
      start_time_text(slit_row) == self.class::LATENESS_MARK
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
