module OfficialWebsite
  class EventSchedulePage
    include ThroughOfficialWebsiteProxy

    attribute :year, :integer
    attribute :month, :integer

    def params
      {
        year: year,
        month: month,
      }
    end
  end
end
