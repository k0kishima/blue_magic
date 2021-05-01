module OfficialWebsite
  module V1707
    module CancellationHandleable
      extend ActiveSupport::Concern

      included do
        def raise_exception_if_canceled!
          raise ::RaceCanceled.new if canceled?
        end

        def canceled?
          html.search('.l-main')&.text&.match(/レース[は]?中止/).present?
        end
      end
    end
  end
end
