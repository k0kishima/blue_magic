module OfficialWebsite
  class EventHoldingsPage < Page
    attribute :date, :date

    def params
      {
        date: date,
      }
    end
  end
end
