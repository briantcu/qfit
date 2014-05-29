# == Schema Information
#
# Table name: user_schedules
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  program_id        :integer
#  program_type_id   :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  sign_up_date      :date
#  created_at        :datetime
#  updated_at        :datetime
#

class UserSchedule < ActiveRecord::Base
  belongs_to :user
  has_many :weekly_schedule_days, -> { order('day ASC') }
  belongs_to :program_type
  belongs_to :program
  accepts_nested_attributes_for :weekly_schedule_days, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  validates_presence_of :user_id, :program_id, :program_type_id, :phase_one_start, :phase_two_start, :phase_three_start,
                        :phase_four_start, :sign_up_date

  def setup_phases
    now = Date.current
    set_dates(now)
  end

  def update_phases(date)
    set_dates(date)
  end

  def set_dates(start_date)
    self.phase_one_start = start_date
    self.phase_two_start = start_date.advance(:weeks => 3)
    self.phase_three_start = self.phase_two_start.advance(:weeks => 3)
    self.phase_four_start = self.phase_three_start.advance(:weeks => 3)
  end

  def create_weekly_schedule_days
    7.times{ |i|
      WeeklyScheduleDay.create(day: i, user_schedule_id: self.id)
    }
  end

  def get_current_phase
    get_phase_by_date(Date.today)
  end

  def get_phase_by_date(date)
    if date.between?(self.phase_one_start, self.phase_two_start)
      return 1
    end

    if date.between?(self.phase_two_start, self.phase_three_start)
      return 2
    end

    if date.between?(self.phase_three_start, self.phase_four_start)
      return 3
    end
    4
  end

  def self.find_by_user_id(user_id)
    UserSchedule.where(:user_id => user_id).first
  end

  def self.create_user_schedule(params)
    user_schedule = UserSchedule.new(params)
    user_schedule.setup_phases
    user_schedule.sign_up_date = Date.current
    user_schedule
  end

  def is_valid_workout_day? (date)
    weekly_schedule_day = self.weekly_schedule_days.at(date.wday)
    weekly_schedule_day.weights || weekly_schedule_day.plyometrics || weekly_schedule_day.sprinting
  end

  def maintain_phases(workout_date)
    phase_four_end = self.phase_four_start.advance(:weeks => 3)
    if workout_date >= phase_four_start
      update_phases(phase_four_end)
    end
    current_phase = self.user.current_phase
    workout_phase = get_phase_by_date(workout_date)
    current_sprint_diff = self.user.sprint_diff
    #This is the first workout in the new phase
    if workout_phase != current_phase
      current_sprint_diff = current_sprint_diff + 1
      self.user.sprint_diff = current_sprint_diff
      self.user.save
    end

    workout_phase
  end

  def get_schedule_day(date)
    #day is base 0, Sun - Sat
    self.weekly_schedule_days.at(date.wday)
  end

end
