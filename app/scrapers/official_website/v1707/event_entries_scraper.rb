module OfficialWebsite
  class V1707::EventEntriesScraper < Scraper
    include OfficialWebsite::V1707::NoContentsHandleable

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

      raise_exception_if_data_not_found!

      raise StandardError if series_entry_rows.count < 12

      data = series_entry_rows.map do |row|
        texts = row.search('td').map{|cell| cell.text.strip }
        racer_names = texts[2].split(/[　]+/).reverse
        {
          racer_registration_number: texts[1].to_i,
          racer_first_name: racer_names.first,
          racer_last_name: racer_names.last,
          racer_rank: texts[3],
          motor_number: texts[4].to_i,
          quinella_rate_of_motor: texts[5].to_f,
          boat_number: texts[6].to_i,
          quinella_rate_of_boat: texts[7].to_f,
          anterior_time: texts[8].to_f,
          racer_gender: row.search('.is-lady').present? ? 'female' : 'male'
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

    def series_entry_rows
      @series_entry_rows ||= html.search('.table1 table tbody tr')
    end
  end
end
