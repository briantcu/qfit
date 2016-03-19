set :output, 'log/cron.log'
#server time is central time + 5 hours

every :day, at: '5:05am' do
  runner 'RoutineService.nightly_workout_creation'
end

every :month do
  runner 'UserPointsService.record_monthly_points'
end