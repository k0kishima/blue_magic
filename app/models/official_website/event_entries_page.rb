module OfficialWebsite
  class EventEntriesPage < Page
    attribute :stadium_tel_code, :integer
    attribute :event_starts_on, :date

    def params
      {
        stadium_tel_code: stadium_tel_code,
        event_starts_on: event_starts_on,
      }
    end
  end
end
