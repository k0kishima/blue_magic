class UpdateRacerGenderJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound, NoMethodError

  def perform(racer_registration_number)
    racer = Racer.find(racer_registration_number)
    return false if racer.gender.present?

    race_entry = RaceEntry.where(racer_registration_number: racer.registration_number).last
    page = OfficialWebsite::EventEntriesPage.new(stadium_tel_code: race_entry.event.stadium_tel_code,
                                                 event_starts_on: race_entry.event.starts_on)

    scraper_class = OfficialWebsite::ScraperClassFactory.create!('event_entry')
    scraper = scraper_class.new(file: page.file)

    racer_attributes = scraper.scrape!.find { |hash|
      hash.fetch(:racer_registration_number) == racer.registration_number
    }
    gender = racer_attributes.fetch(:racer_gender)

    racer.update!(gender: gender)
  end
end
