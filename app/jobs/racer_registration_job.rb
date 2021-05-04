class RacerRegistrationJob < ApplicationJob
  include CrawlingNotifiable

  discard_on(ActiveRecord::RecordInvalid) do |job, error|
    job.notify_information([job.arguments, error.message].join(':'))
  end

  def perform(racer_registration_number)
    scraper_class = OfficialWebsite::ScraperClassFactory.create!('racer_profile')
    page = OfficialWebsite::RacerProfilePage.new(racer_registration_number: racer_registration_number)
    scraper = scraper_class.new(file: page.file)

    begin
      attributes = scraper.scrape!.first
      Racer.active.create!(
        registration_number: racer_registration_number,
        last_name: attributes.fetch(:last_name),
        first_name: attributes.fetch(:first_name, ''),
        term: attributes.fetch(:term),
        birth_date: attributes.fetch(:birth_date),
        branch_id: JpPrefecture::Prefecture.find(name: attributes.fetch(:branch_prefecture)).try(:code),
        birth_prefecture_id: JpPrefecture::Prefecture.find(name: attributes.fetch(:born_prefecture)).try(:code),
        height: attributes.fetch(:height),
      )
      UpdateRacerGenderJob.perform_later(racer_registration_number)
    rescue DataNotFound
      Racer.retired.create!(registration_number: racer_registration_number)
      UpdateRacerGenderJob.perform_later(racer_registration_number)
    end
  end
end
