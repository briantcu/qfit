class UserCalendar
  include ActiveAttr::BasicModel
  include ActiveAttr::TypecastedAttributes
  include ActiveAttr::MassAssignment
  include ActiveModel::Validations

  attribute :user_id, type: Integer
  attribute :month_id, type: Integer
  attribute :year_id, type: Integer
  attribute :calendar_month

  validates :user_id, presence: true
  validates :year_id, presence: true, :inclusion => {:in => 2010..2149}
  validates :month_id, presence: true, :inclusion => {:in => 1..12}
  validate :must_have_user

  def populate_calendar
    self.calendar_month = CalendarMonth.new
    self.calendar_month.days = []
    first_of_month = Date.new(self.year_id, self.month_id, 1)
    end_of_month = first_of_month.end_of_month.day
    user = User.find(self.user_id)
    routines = DailyRoutine.get_routines_for_month(self.user_id, self.month_id, self.year_id)

    pad_month(normalize_day(first_of_month.cwday))

    for d in 1..end_of_month
      day = Date.new(self.year_id, self.month_id, d)
      routine = find_routine_for_date(routines, day)

      if routine.nil?
        workout_status = 'nothing'
        if user.will_workout_for_day?(normalize_day(day.cwday))
          workout_status = 'future'
        end
        self.calendar_month.days << CalendarDay.new(:day_of_month => d, :day_of_week => normalize_day(day.cwday),
                                                    :daily_routine_id => 0, :workout_status => workout_status)
      else
        self.calendar_month.days << CalendarDay.new(:day_of_month => d, :day_of_week => normalize_day(day.cwday),
                                                    :daily_routine_id => routine.id,
                                                    :workout_status => routine.get_workout_status)
      end
    end

    self

  end

  def pad_month(first_of_month)

    for i in 1..first_of_month
      self.calendar_month.days << CalendarDay.new(:day_of_month => 0, :day_of_week => 0,
                                                  :daily_routine_id => 0,
                                                  :workout_status => 'nothing')
    end
  end

  def normalize_day(day)
    (day == 7) ? 0 : day #Normalize Sunday
  end

  def must_have_user
    errors.add(:base, 'Invalid user id') unless User.where(:id => self.user_id).count == 1
  end

  def find_routine_for_date(routines, day)
    routines.find { |item|
      day == item.day_performed
    }
  end

end