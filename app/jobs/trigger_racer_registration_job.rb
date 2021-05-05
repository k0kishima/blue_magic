class TriggerRacerRegistrationJob < ApplicationJob
  include CrawlingPauseable

  def perform
    race_entered_racer_registration_numbers = RaceEntry.pluck(:racer_registration_number).uniq
    persisted_racer_registration_numbers = Racer.pluck(:registration_number).uniq
    unexistence_racer_registration_numbers = race_entered_racer_registration_numbers - persisted_racer_registration_numbers

    unexistence_racer_registration_numbers.first(10).each do |racer_registration_number|
      RacerRegistrationJob.perform_later(racer_registration_number)
    end
  end
end
