module OfficialWebsite::V1707
  class EventHoldingsScraper
    CANCELED_TEXTS = %w(中止順延	中止)

    def initialize(file)
      @file = file
    end

    def scrape!
      race_information_tbodies.map do |tbody|
        {
          stadium_tel_code: stadium_tel_code(tbody.elements.to_s),
          day_text: canceled?(tbody.text) ? cancel_text(tbody.text) : day_text(tbody.text),
        }
      end
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def race_information_tbodies
      @race_information_tbodies ||= html.search('.table1').first.search('table tbody')
    end

    def cancel_text(text)
      text.scan(/(#{CANCELED_TEXTS.join('|')})/).flatten.first
    end

    def stadium_tel_code(html_string)
      matched = html_string.scan(/\?jcd=(\d{2})/)
      raise StandardError.new('perhaps invalid file given.') if matched.blank?

      matched.flatten.first.to_i
    end

    def canceled?(text)
      /\b(#{CANCELED_TEXTS.join('|')})/.match(text)
    end

    def day_text(text)
      text.scan(/(初日|[\d１２３４５６７]日目|最終日)/).flatten.first
    end
  end
end
