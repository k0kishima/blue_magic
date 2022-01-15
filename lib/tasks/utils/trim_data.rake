namespace :utils do
  # e.g.
  # docker-compose exec app bundle exec rake utils:trim_data_for_specified_term
  desc 'remove data which are not included specified racer evaluation term'
  task trim_data_for_specified_term: :environment do
    puts 'Enter year'
    print '> '
    year = STDIN.gets.chomp.to_i
    raise ArgumentError.new('the inputted year is invalid.') if year.zero?

    puts 'Select half of term by below option'
    puts '1: first'
    puts '2: second'
    print '> '
    half = case STDIN.gets.chomp.to_i
    when 1
      'first'
    when 2
      'second'
    else
      raise ArgumentError.new('need to specified half of term by 1 or 2')
    end

    starts_on = RacerRatingEvaluationTerm.try("#{half}_half_starts_on", year: year)
    ends_on = RacerRatingEvaluationTerm.try("#{half}_half_ends_on", year: year)

    puts "remove data which are not included between #{starts_on} to #{ends_on}."
    puts 'ok? (y/N)'
    print '> '
    confirmation = STDIN.gets.chomp
    abort 'aborted.' unless confirmation == 'y'

    puts 'Data deletion is in progress...'

    RacerWinningRateAggregation.where.not(aggregated_on: starts_on..ends_on).delete_all
    BoatBettingContributeRateAggregation.where.not(aggregated_on: starts_on..ends_on).delete_all
    MotorBettingContributeRateAggregation.where.not(aggregated_on: starts_on..ends_on).delete_all
    BoatSetting.where.not(date: starts_on..ends_on).delete_all
    WinningRaceEntry.where.not(date: starts_on..ends_on).delete_all
    RaceRecord.where.not(date: starts_on..ends_on).delete_all
    CircumferenceExhibitionRecord.where.not(date: starts_on..ends_on).delete_all
    StartExhibitionRecord.where.not(date: starts_on..ends_on).delete_all
    DisqualifiedRaceEntry.where.not(date: starts_on..ends_on).delete_all
    RaceEntry.where.not(date: starts_on..ends_on).delete_all
    Odds.where.not(date: starts_on..ends_on).delete_all
    Payoff.where.not(date: starts_on..ends_on).delete_all
    Race.where.not(date: starts_on..ends_on).delete_all
    WeatherCondition.where.not(date: starts_on..ends_on).delete_all
    RacerCondition.where.not(date: starts_on..ends_on).delete_all
    MotorMaintenance.where.not(date: starts_on..ends_on).delete_all
    MotorRenewal.where.not(date: starts_on..ends_on).delete_all
    Event.where.not(starts_on: starts_on..ends_on).delete_all

    puts 'Done.'
  end
end
