module OfficialWebsite
  class V1707::OddsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable
    include OfficialWebsite::V1707::NoContentsHandleable
    include OfficialWebsite::V1707::CancellationHandleable

    def scrape!
      validate!

      raise_exception_if_data_not_found!
      raise_exception_if_canceled!

      raise StandardError.new('perhaps invalid file given.') if odds_cells.blank?

      data = []

      odds_cells.each_with_index do |odds_cell, i|
        betting_number = [first_arrived(i), second_arrived(i), third_arrived(i)].join

        data << {
          date: date,
          stadium_tel_code: stadium_tel_code,
          race_number: race_number,
          betting_number: betting_number.to_i,
          ratio: odds_cell.text.to_f
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

    def odds_table
      @odds_table ||= html.search('.table1')[1]
    end

    def odds_cells
      @odds_cells ||= odds_table.search('tbody tr td.oddsPoint')
    end

    def second_arrived_cells
      @second_arrived_cells ||= odds_table.search('tbody tr td[rowspan="4"]')
    end

    def second_arrived_numbers
      @second_arrived_numbers ||= second_arrived_cells.map(&:text).each_slice(6).to_a.map { |numbers|
        numbers * 4
      }.flatten
    end

    def second_arrived(loop_offset)
      second_arrived_numbers[loop_offset]
    end

    def third_arrived_cells
      @third_arrived_cells ||= odds_table.search('tbody tr td[class^="is-boatColor"]')
    end

    def third_arrived(loop_offset)
      third_arrived_cells.map(&:text)[loop_offset]
    end

    def closed?
      html.search('p.tab4_time').present?
    end

    def status
      closed? ? :closed : :open
    end

    def bet_method
      case odds_table.search('tbody tr td.oddsPoint').count
      when 120
        '3permutation'
      end
    end

    def first_arrived(loop_offset)
      raise NotImplementedError.new unless bet_method == '3permutation'

      (loop_offset % 6).next
    end
  end
end
