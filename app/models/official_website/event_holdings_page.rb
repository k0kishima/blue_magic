module OfficialWebsite
  class EventHoldingsPage
    include ThroughOfficialWebsiteProxy

    attribute :date, :date

    def params
      {
        date: date,
      }
    end
  end
end
