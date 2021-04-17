module OfficialWebsite
  class RaceResultPage < Page
    attribute :stadium_tel_code, :integer
    attribute :race_opened_on, :date
    attribute :race_number, :integer

    def params
      {
        stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on,
        race_number: race_number,
      }
    end
  end
end
