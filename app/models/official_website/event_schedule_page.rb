module OfficialWebsite
  class EventSchedulePage < Page
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
