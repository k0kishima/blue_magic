class CancelRaceJob < ApplicationJob
  retry_on ActiveRecord::RecordNotFound, wait: 10.minutes, attempts: 3

  def perform(stadium_tel_code:, race_opened_on:, race_number:)
    race = Race.find_by!(stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number)
    race.update!(canceled: true)
  end
end
