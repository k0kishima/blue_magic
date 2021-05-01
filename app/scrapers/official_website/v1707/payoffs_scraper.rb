module OfficialWebsite
  class V1707::PayoffsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable
    include OfficialWebsite::V1707::NoContentsHandleable

    SIMULTANEOUS_TEXT = '同着あり'
    SPECIAL_PAY_TEXT  = '特払い'
    RACE_CANCELED_TEXT = 'レース中止'

    def scrape!
      validate!

      raise_exception_if_data_not_found!

      raise ::RaceCanceled.new if canceled?

      data = number_and_amount_pairs(trifecta_tbody).compact.map do |attribute|
        {
          date: date,
          stadium_tel_code: stadium_tel_code,
          race_number: race_number,
          betting_method: :trifecta,
          betting_number: attribute[:betting_number],
          amount: attribute[:amount]
        }
      end

      self.cache = data

      data
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def payment_table
      @payment_table ||= html.search('.table1')[3]
    end

    def trifecta_tbody
      @trifecta_tbody ||= payment_table.search('tbody')[0]
    end

    def number_and_amount_pairs(tbody)
      rowspan = tbody.search('td').first.attribute('rowspan').value

      tbody.search('tr').map do |tr|
        tds = tr.search('td:not([rowspan="' + rowspan + '"])')

        betting_number = tds[0].search('span.numberSet1_number').map(&:text).map(&:to_i).join('-')
        amount = tds[1].text.gsub(/[^0-9]/, '').to_i

        { betting_number: betting_number, amount: amount, } if betting_number.present?
      end
    end

    def canceled?
      html.search('.l-main').text.match(/#{RACE_CANCELED_TEXT}/).present?
    end
  end
end
