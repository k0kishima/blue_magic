module OfficialWebsite
  class V1707::RacerProfileScraper < Scraper
    def scrape!
      raise ::DataNotFound if retired?

      # NOTE: 級別・体重・性別はファイルダウンロード時点のものであるため変動する可能性がある
      # 稀ではあるが支部も変わることがある
      {
        last_name: last_name,
        first_name: first_name.presence || '',
        registration_number: registration_number,
        birth_date: birth_date.to_s,
        height: height,
        weight: weight,
        branch_prefecture: branch_prefecture,
        born_prefecture: born_prefecture,
        term: term,
        current_rating: current_rating
      }
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def full_name
      @full_name ||= html.search('.racer1_bodyName').text
    end

    def names
      @names ||= full_name.split(/[\s　]+/)
    end

    def last_name
      @last_name ||= names[0]
    end

    def first_name
      @first_name ||= names[1]
    end

    def profile_fields
      @profile_fields ||= html.search('dl.list3')
    end

    def registration_number
      @registration_number ||= profile_fields.search('dd')[0].text.to_i
    end

    def birth_date
      @birth_date ||= profile_fields.search('dd')[1].text.to_date
    end

    def height
      @height ||= profile_fields.search('dd')[2].text.to_i
    end

    def weight
      @weight ||= profile_fields.search('dd')[3].text.to_i
    end

    def branch_prefecture
      @branch_prefecture ||= profile_fields.search('dd')[5].text
    end

    def born_prefecture
      @born_prefecture ||= profile_fields.search('dd')[6].text
    end

    def term
      @term ||= profile_fields.search('dd')[7].text.to_i
    end

    def current_rating
      @current_rating ||= profile_fields.search('dd')[8].text
    end

    def blood_type
      @blood_type ||= profile_fields.search('dd')[4].text
    end

    def retired?
      html.text.match?(/データが存在しないのでページを表示できません。/)
    end
  end
end
