module OfficialWebsite
  module V1707
    module NoContentsHandleable
      extend ActiveSupport::Concern

      included do
        def raise_exception_if_data_not_found!
          raise ::DataNotFound.new if data_not_found?
        end

        def data_not_found?
          html.search('.l-main')&.text&.match(/データ[がは]ありません/).present?
        end
      end
    end
  end
end
