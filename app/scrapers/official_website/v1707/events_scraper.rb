module OfficialWebsite::V1707
  class EventsScraper
    def initialize(file)
      @file = file
    end

    def scrape!
      raise StandardError.new('perhaps invalid file given.') if schedule_rows.blank?

      data = []

      schedule_rows.each.with_index(1) do |schedule_row, stadium_tel_code|
        date_pointer = offset_day

        schedule_row.search('td').each do |series_cell|
          break if date.end_of_month < date_pointer

          series_days = series_cell.attribute('colspan').try(:value).to_i
          if series_days.zero?
            date_pointer = date_pointer.next_day
            next
          end

          if date <= date_pointer
            data << {
              stadium_tel_code: stadium_tel_code,
              title: series_cell.text,
              # NOTE: 基本的に日付が文字列で取得できるならそのまま加工しないが、
              # これはDateオブジェクトを逆に文字列にしたりしたら不自然な処理なのでこのままDateを返す
              starts_on: date_pointer,
              days: series_days,
              # NOTE: 実質enumまで掘り下げてしまっているがHTMLのclassからしか判別できないこともあり、これに関しては止むを得ない
              grade: grade_by(html_class: series_cell.attribute('class').value,
                              title: series_cell.text).downcase,
              kind: kind_by(html_class: series_cell.attribute('class').value,
                            title: series_cell.text).downcase,
            }
          end

          date_pointer += series_days.days
        end
      end

      data
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def prev_year_month_params_value
      @prev_year_month_params_value ||= \
        html.search('li.title2_navsLeft a').attribute('href').value.match(/\?ym=(\d{6})/)[1]
    end

    def prev_year
      @prev_year ||= prev_year_month_params_value[0..3].to_i
    end

    def prev_month
      @prev_month ||= prev_year_month_params_value[4..5].to_i
    end

    def prev_calender_date
      @prev_calender_date ||= Date.new(prev_year, prev_month)
    end

    def date
      @date ||= prev_calender_date.next_month
    end

    def calender_row
      @calender_row ||= html.search('table thead tr').first
    end

    def schedule_rows
      @schedule_rows ||= html.search('table.is-spritedNone1 tbody tr')
    end

    def start_day
      @start_day ||= calender_row.search('th')[1].text.to_i
    end

    def offset_day
      @offset_day ||= (start_day == 1) ? date : date.prev_month.change(day: start_day)
    end

    def grade_by(html_class:, title:)
      grade = case html_class
              when 'is-gradeColorSG'
                'SG'
              when 'is-gradeColorG1'
                'G1'
              when 'is-gradeColorG2'
                'G2'
              when 'is-gradeColorG3', 'is-gradeColorLady'
                'G3'
              end

      return grade if grade.present?

      match = title.tr('ＧⅠⅡⅢ１２３', 'G123123').match(/G[1-3]{1}/)
      if match.present?
        match[0]
      else
        'no_grade'
      end
    end

    def kind_by(html_class:, title:)
      kind = case html_class
             when 'is-gradeColorRookie'
               'rookie'
             when 'is-gradeColorVenus'
               'venus'
             when 'is-gradeColorLady'
               'all_ladies'
             when 'is-gradeColorTakumi'
               'senior'
             end
      return kind if kind.present?
      return 'double_winner' if title.match(/男女[wWＷ]優勝戦/)

      'uncategorized'
    end
  end
end
