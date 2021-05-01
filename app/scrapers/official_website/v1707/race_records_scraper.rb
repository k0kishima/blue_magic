module OfficialWebsite
  class V1707::RaceRecordsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable
    include OfficialWebsite::V1707::NoContentsHandleable

    module RACE_TIME_DELIMITER
      MINUTE = "'"
      SECOND = '"'
    end
    RACE_CANCELED_TEXT = 'レース中止'
    WINNING_TRICK_NAME_REGEXP = /(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+/

    # ※ キワモノ的なコード（例えば公式サイトがリニューアルされたら用途がかなり限定的になり、通常の運用では使用しなくなる）なのでリファクタの予定はない
    # rubocop:disable Metrics/AbcSize
    def scrape!
      validate!

      raise_exception_if_data_not_found!

      raise ::RaceCanceled.new if canceled?

      @data = record_rows.map do |record_row|
        record = {
          date: date,
          stadium_tel_code: stadium_tel_code,
          race_number: race_number,
          pit_number: color_on_record_table(record_row),
          time_minute: race_time_minute(record_row),
          time_second: race_time_second(record_row),
          start_course: nil,
          start_time: nil,
          winning_trick_name: nil,
        }
        arrival = arrival(record_row)
        if completed?(arrival)
          # 完走
          record[:arrival] = arrival.to_i
          record[:disqualification_mark] = nil
        else
          # 失格
          # NOTE:
          # 失格記号で失格データを示すのは汎用性がないがここ以下の理由で許容する
          # * 競技のデータ公開のフォーマットの伝統から失格の正式名称ではなくこのような記号や略称で表記することは公式サイトがリニューアルされても続くと推測される
          # * enum や正式名称の文字列に変えるのに実装コストや依存関係の追加が発生する
          # ただ、失格記号自体は公式サイトリニューアルで修正される可能性はある（そもそもアイコンになってしまったり、全角半角が変わったりなど）
          # この辺の差異はインポート処理時にアダプタなどで吸収する方針とする
          record[:arrival]               = nil
          record[:disqualification_mark] = arrival
        end

        record
      end

      start_time_rows.each.with_index(1) do |start_time_row, start_course|
        # ※出遅れ or 欠場の場合はスタート情報を記録しない
        if record = saved_record(color_on_start_time_table(start_time_row))
          record[:start_course] = start_course
          record[:start_time]   = start_time(start_time_row)
        end

        record[:winning_trick_name] = winning_trick(start_time_row) if record[:arrival] == 1
      end

      sorted_start_times = data
                           .select { |hash| hash[:start_time].present? && hash[:disqualification_mark] != 'Ｆ' }
                           .sort_by { |hash| hash[:start_time] }
                           .map { |hash| hash[:start_time] }
      data.each do |hash|
        hash[:start_order] = sorted_start_times.index(hash[:start_time])&.next
      end

      data.sort_by! { |hash| hash[:pit_number] }

      self.cache = data

      data
    end
    # rubocop:enable Metrics/AbcSize

    private

    attr_reader :file, :data

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def record_table
      @record_table ||= html.search('.table1')[1]
    end

    def record_rows
      @record_rows ||= record_table.search('tbody')
    end

    def start_time_table
      @start_time_table ||= html.search('.table1')[2]
    end

    def start_time_rows
      @start_time_rows ||= start_time_table.search('tbody tr')
    end

    def color_on_record_table(record_row)
      record_row.search('td')[1].text.to_i
    end

    def race_time_text(record_row)
      record_row.search('td')[3].text
    end

    def race_time_minute(record_row)
      race_time_text = race_time_text(record_row)
      return nil if race_time_text.blank?

      race_time_text.scan(/^(\d)/).flatten.first.to_i
    end

    def race_time_second(record_row)
      race_time_text = race_time_text(record_row)
      return nil if race_time_text.blank?

      race_time_text.scan(/^\d'([\d"]+)/).flatten.first.gsub(RACE_TIME_DELIMITER::SECOND, '.').to_f
    end

    def arrival(record_row)
      record_row.search('td')[0].text.tr('０-９', '0-9')
    end

    def completed?(arrival)
      arrival.match(/[1-6]{1}/)
    end

    def color_on_start_time_table(start_time_row)
      start_time_row.search('span').first.text.to_i
    end

    def saved_record(pit_number)
      data.find { |record| record[:pit_number] == pit_number }
    end

    def start_time(start_time_row)
      # ここではタイムの絶対値だけに着目する
      # フライングかどうかは考慮しない
      # フライングの有無が検討必要な箇所では失格記号(フライングの場合はF)の判定で適宜制御する
      after_the_decimal_point = start_time_row.search('span').last.text.scan(/^F?\.(\d+)/).flatten.first
      "0.#{after_the_decimal_point}".to_f
    end

    def winning_trick(start_time_row)
      start_time_row.search('.table1_boatImage1TimeInner').text.scan(WINNING_TRICK_NAME_REGEXP).flatten.first
    end

    def canceled?
      html.search('.l-main').text.match(/#{RACE_CANCELED_TEXT}/).present?
    end
  end
end
