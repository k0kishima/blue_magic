module OfficialWebsite
  class RacerProfilePage
    include ThroughOfficialWebsiteProxy

    attribute :racer_registration_number, :integer

    def params
      {
        registration_number: racer_registration_number,
      }
    end
  end
end
