module OfficialWebsite
  module V1707
    module NoContentsHandleable
      extend ActiveSupport::Concern

      DATA_NOT_FOUND_TEXT = 'データがありません。'

      included do
        def raise_exception_if_data_not_found!
          raise ::DataNotFound.new if data_not_found?
        end

        def data_not_found?
          html.search('.l-main').text.match(/#{DATA_NOT_FOUND_TEXT}/).present?
        end
      end
    end
  end
end
