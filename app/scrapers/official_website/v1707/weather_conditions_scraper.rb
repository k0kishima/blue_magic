module OfficialWebsite
  class V1707::WeatherConditionsScraper < Scraper
    include OfficialWebsite::V1707::RacePageBreadcrumbsScrapable
    include OfficialWebsite::V1707::NoContentsHandleable
    include OfficialWebsite::V1707::CancellationHandleable

    STRIP_REGEXP = /[ 　\r\n]/
    WIND_ICON_IDS = 1..16
    NO_WIND_ICON_ID = 17

    def scrape!
      validate!

      raise_exception_if_data_not_found!
      raise_exception_if_canceled!

      raise ::RaceCanceled.new if canceled?
      raise ::DataNotFound.new if incomplete_information?

      data = [{
        date: date,
        stadium_tel_code: stadium_tel_code,
        race_number: race_number,
        in_performance: in_performance?,
        weather: weather,
        wavelength: wavelength.to_f,
        wind_angle: wind_angle.to_f,
        wind_velocity: wind_velocity.to_f,
        air_temperature: air_temperature.to_f,
        water_temperature: water_temperature.to_f,
      }]

      self.cache = data

      data
    end

    private

    attr_reader :file

    def html
      @html ||= Nokogiri::HTML.parse(file.read)
    end

    def data_container
      @data_container ||= html.search('.weather1')
    end

    def weather
      data_container.search('.is-weather').text.gsub(STRIP_REGEXP, '')
    end

    def wind_direction_id_in_official
      # is-wind1〜16 まである。1から時計回りで方向変わっていく
      @wind_direction_id_in_official ||= data_container
                                         .search('.is-windDirection').search('p').attribute('class').value
                                         .scan(/is-wind(\d{1,2})/).flatten.first.to_i
    end

    def wind_angle
      return nil if NO_WIND_ICON_ID == wind_direction_id_in_official

      unless wind_direction_id_in_official.in?(WIND_ICON_IDS)
        raise StandardError.new("Detect first look wind direction id: #{wind_direction_id_in_official}")
      end

      # NOTE: 方位を角度とする。スリットの北が0度。
      # http://boatrace.jp/static_extra/pc/images/icon_wind1_1.png
      # wind_clock_anglesのコメントにより配列の先頭の要素は0°が相当して22.5°ずつ増えていく
      #
      # wind_clock_angles[1.pred]
      # => 0.0
      # wind_clock_angles[2.pred]
      # => 22.5
      # wind_clock_angles[5.pred]
      # => 90.0
      # wind_clock_angles[16.pred]
      # => 337.5
      wind_clock_angles[wind_direction_id_in_official.pred]
    end

    def wavelength
      data_container.search('.weather1_bodyUnitLabelData')[3].text.gsub(STRIP_REGEXP, '')
    end

    def wind_velocity
      data_container.search('.weather1_bodyUnitLabelData')[1].text.gsub(STRIP_REGEXP, '')
    end

    def air_temperature
      data_container.search('.weather1_bodyUnitLabelData')[0].text.gsub(STRIP_REGEXP, '')
    end

    def water_temperature
      data_container.search('.weather1_bodyUnitLabelData')[2].text.gsub(STRIP_REGEXP, '')
    end

    def wind_clock_angles
      @wind_clock_angles ||= -> do
        step = 360.0 / WIND_ICON_IDS.count
        0.step(360 - step, step).to_a
      end.call
    end

    def incomplete_information?
      html.search('.weather1_title').text =~ /0:00/ ||
        (wavelength.blank? && wind_velocity.blank? && air_temperature.blank? && water_temperature.blank?)
    end

    def active_tab
      html
        .search(
          'body > main > div > div > div > div.contentsFrame1_inner > div.tab3.is-type1__3rdadd > ul > li.is-active'
        )
    end

    def in_performance?
      case active_tab.text
      when '直前情報'
        false
      when '結果'
        true
      else
        raise NotImplementedError
      end
    end
  end
end
