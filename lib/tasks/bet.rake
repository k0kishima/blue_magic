namespace :bet do
  # e.g. docker-compose exec app bundle exec rake bet:enqueue_bet_jobs FORECASTER_ID=1 FROM=2018-04-01 TO=2018-04-01 
  desc 'enque bet jobs '
  task enqueue_bet_jobs: :environment do
    forecaster_id = ENV['FORECASTER_ID'].to_i

    (ENV['FROM'].to_date..ENV['TO'].to_date).each do |date|
      Race.where(date: date).each do |race|
        next if race.canceled?

        BetJob.perform_later(
          race_opened_on: race.date,
          stadium_tel_code: race.stadium_tel_code,
          race_number: race.race_number,
          forecaster_id: forecaster_id
        )
      end
    end
  end
end