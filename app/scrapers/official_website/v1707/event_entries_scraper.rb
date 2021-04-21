module OfficialWebsite
  class V1707::EventEntriesScraper < Scraper
    DATA_NOT_FOUND_TEXT = '※ データはありません。'

    # NOTE:
    #
    # このバージョンの公式サイトだと、このパーサーが処理するページ（前検結果）からしかレーサーの性別が取得できない
    # 性別の明記がない理由は、各ページ（プロフィールや出走表）には写真があり、男女で背景色も違うことからから外観から明らかであるためと思われる
    # このクラスは性別以外に使う項目はないのだが上記の事情があるので実装を残している
    #
    # なのでここで取得できなかった性別は当面は運用カバーで手動更新
    # TODO: ↑運用カバーでなんとかしない
    # このバージョンの公式サイトの仕様上どうしようもないのかもしれないがせめて自動で更新するようにはしたい
    def scrape!
      validate!

      raise ::DataNotFound.new if data_not_found?

      data = series_entry_rows.map do |row|
        cells = row.search('td')
        racer_names = cells[2].text.strip.split(/[　]+/).reverse
        {
          racer_registration_number: cells[1].text.to_i,
          racer_first_name: racer_names.first,
          racer_last_name: racer_names.last,
          racer_rank: cells[3].text,
          motor_number: cells[4].text.to_i,
          quinella_rate_of_motor: cells[5].text.to_f,
          boat_number: cells[6].text.to_i,
          quinella_rate_of_boat: cells[7].text.to_f,
          anterior_time: cells[8].text.to_f,
          racer_gender: row.search('.is-lady').present? ? 'female' : 'male'
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

    def series_entry_rows
      @series_entry_rows ||= html.search('.table1 table tbody tr')
    end

    def data_not_found?
      html.search('.l-main').text.match(/#{DATA_NOT_FOUND_TEXT}/).present?
    end
  end
end
