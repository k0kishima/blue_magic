module OfficialWebsite
  class V1707::RaceInformationsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable

    module TEXT
      COURSE_FIXED = '進入固定'
      USE_STABILIZER = '安定板使用'
    end

    def scrape!
      validate!

      data = [{
        date: date,
        stadium_tel_code: stadium_tel_code,
        number: race_number,
        is_course_fixed: course_fixed?,
        use_stabilizer: use_stabilizer?,
        deadline: deadline_text,
        title: title,
        metre: metre,
      }]

      self.cache = data

      data
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def course_fixed?
      html.search('.label2.is-type1').select { |label| label.text == TEXT::COURSE_FIXED }.present?
    end

    def outside_deladline_rows
      @outside_deladline_rows ||= deadline_table.search('tbody tr').last
    end

    def deadline_text
      outside_deladline_rows.search('td')[race_number].text
    end

    def title
      html.search('.heading2_titleDetail').text.scan(/([^\n]+)\n/).flatten.first.strip.gsub(/[　 ]+/, '')
    end

    def metre
      html.search('.heading2_titleDetail').text.scan(/(\d{3,4}m)/).flatten.first.to_i
    end

    def use_stabilizer?
      html.search('.label2.is-type1').select { |label| label.text == TEXT::USE_STABILIZER }.present?
    end
  end
end
