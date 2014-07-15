# == Schema Information
#
# Table name: group_schedules
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  program_id        :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  created_at        :datetime
#  updated_at        :datetime
#

class GroupSchedule < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  belongs_to :group
  has_many :group_schedule_days
  accepts_nested_attributes_for :group_schedule_days, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  validates_presence_of :group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start,
                        :phase_four_start

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
      GroupScheduleDay.create(day: i, group_schedule_id: self.id)
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

  def self.find_by_group_id(group_id)
    GroupSchedule.where(:group_id => group_id).first
  end

  def self.create_group_schedule(params)
    group_schedule = GroupSchedule.new(params)
    group_schedule.setup_phases
    group_schedule
  end

  def is_valid_workout_day? (date)
    weekly_schedule_day = self.group_schedule_days.at(date.wday)
    weekly_schedule_day.weights || weekly_schedule_day.plyometrics || weekly_schedule_day.sprinting
  end

  def maintain_phases(workout_date)
    phase_four_end = self.phase_four_start.advance(:weeks => 3)
    if workout_date >= phase_four_start
      update_phases(phase_four_end)
    end
    current_phase = self.group.current_phase
    workout_phase = get_phase_by_date(workout_date)
    current_sprint_diff = self.group.sprint_diff
    #This is the first workout in the new phase
    if workout_phase != current_phase
      current_sprint_diff = current_sprint_diff + 1
      self.group.sprint_diff = current_sprint_diff
      self.group.save
    end

    workout_phase
  end

  def get_schedule_day(date)
    #day is base 0, Sun - Sat
    self.group_schedule_days.at(date.wday)
  end

  def get_total_days_of_pillar(type)
    total_days = 0
    case type
      when STRETCHING
        total_days = self.group_schedule_days.where(:stretching => true).size
      when WEIGHTS
        total_days = self.group_schedule_days.where(:weights => true).size
      when PLYOS
        total_days = self.group_schedule_days.where(:plyometrics => true).size
      when SPRINTING
        total_days = self.group_schedule_days.where(:sprinting => true).size
    end
    total_days
  end

end
