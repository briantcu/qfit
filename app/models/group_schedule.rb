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

  after_save :create_weekly_schedule_days, on: :create
  belongs_to :group
  has_many :group_schedule_days, -> { order('day ASC') }
  accepts_nested_attributes_for :group_schedule_days, allow_destroy: true
  validates_presence_of :group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start

  def invalid?
    phase_one_start.blank?
  end

  def setup_phases
    now = Date.today
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
      GroupScheduleDay.find_or_create_by(day: i, group_schedule_id: self.id)
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
      if current_phase % 2 == 0
        current_sprint_diff = current_sprint_diff + 1
        self.group.sprint_diff = current_sprint_diff
        self.group.save!
      end
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
        total_days = self.group_schedule_days.where(:stretching => true).count
      when WEIGHTS
        total_days = self.group_schedule_days.where(:weights => true).count
      when PLYOS
        total_days = self.group_schedule_days.where(:plyometrics => true).count
      when SPRINTING
        total_days = self.group_schedule_days.where(:sprinting => true).count
    end
    total_days
  end

  def rollback_days_created
    weights = 0
    warmup = 0
    plyos = 0
    sprints = 0
    open_workouts = RoutineService.get_open_workouts_start_today(self.group)
    open_workouts.each do |workout|
      if workout.wt_day_id != 0
        weights = weights + 1
      end
      if workout.pl_day_id != 0
        plyos = plyos + 1
      end
      if workout.wu_day_id != 0
        warmup = warmup + 1
      end
      if workout.sp_day_id != 0
        sprints = sprints + 1
      end
    end

    rollback_weights(weights)
    rollback_pillar(warmup, STRETCHING)
    rollback_pillar(sprints, SPRINTING)
    rollback_pillar(plyos, PLYOS)

  end

  private

  def rollback_weights(count)
    if count > 0
      last_day = self.group.get_last_day_created(WEIGHTS)
      1..count do
        if last_day == 1
          rollback = ProgramDaySequence.get_total_days(self.program_id)
        else
          rollback = last_day - 1
        end
      end

      if rollback <= 0
        rollback = 1
      end

      self.group.note_last_day_created(rollback, WEIGHTS)
    end
  end

  def rollback_pillar(count, type)
    if count > 0
      last_day = self.group.get_last_day_created(type)

      1..count do
        if last_day == 1
          rollback = self.get_total_days_of_pillar(type)
        else
          rollback = last_day - 1
        end
      end

      if rollback <= 0
        rollback = 1
      end

      self.group.note_last_day_created(rollback, type)

    end
  end

end
