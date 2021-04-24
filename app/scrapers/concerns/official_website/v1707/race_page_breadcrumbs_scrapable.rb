module OfficialWebsite
  module V1707
    module RacePageBreadcrumbsScrapable
      extend ActiveSupport::Concern

      included do
        def todays_race_list_url
          @todays_race_list_url ||= html
                                    .search('body > div.l-header > ul > li:nth-child(3) > a')
                                    .attribute('href')
                                    .value
        end

        def stadium_tel_code
          @stadium_tel_code ||= todays_race_list_url.scan(/\?.*jcd=(\d{2})/).flatten.first.to_i
        end

        def date
          date_string = todays_race_list_url.scan(/\?.*hd=(\d{8})/).flatten.first
          Date.new(*[date_string[0..3], date_string[4..5], date_string[6..7]].map(&:to_i))
        end
      end
    end
  end
end
