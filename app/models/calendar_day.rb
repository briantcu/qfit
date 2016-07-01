class CalendarDay
  include ActiveModel::Model

  attr_accessor :day_of_week, :day_of_month, :workout_status, :daily_routine_id, :month

end