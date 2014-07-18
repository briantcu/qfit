# == Schema Information
#
# Table name: daily_routines
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  group_id           :integer
#  day_performed      :date
#  weight             :integer
#  power_index        :integer
#  count_ex_provided  :integer
#  count_ex_completed :integer
#  program_day_id     :integer
#  wt_day_id          :integer
#  sp_day_id          :integer
#  pl_day_id          :integer
#  wu_day_id          :integer
#  modified           :boolean
#  pl_modified        :boolean
#  wt_modified        :boolean
#  wu_modified        :boolean
#  sp_modified        :boolean
#  changes_saved      :boolean
#  closed             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  group_routine_id   :integer
#

class DailyRoutine < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3


  belongs_to :user
  has_many :custom_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_plyometrics, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_sprints, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_warm_ups, -> { order('id ASC') }, :foreign_key => :routine_id

  accepts_nested_attributes_for :custom_exercises, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_warm_ups, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_exercises, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_plyometrics, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_sprints, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def get_warmups
    self.performed_warm_ups
  end

  def get_weights
    self.performed_exercises
  end

  def get_sprints
    self.performed_sprints
  end

  def get_plyos
    self.performed_plyometrics
  end

  def get_custom_exercises(type)
    case type
      when STRETCHING
        return self.custom_exercises.where(ex_type: STRETCHING)
      when WEIGHTS
        return self.custom_exercises.where(ex_type: WEIGHTS)
      when PLYOS
        return self.custom_exercises.where(ex_type: PLYOS)
      when SPRINTING
        return self.custom_exercises.where(ex_type: SPRINTING)
    end
  end

  def self.get_routines_for_month(user_id, month, year)
    first = Date.new(year, month, 1)
    last = first.end_of_month
    DailyRoutine.where(:user_id => user_id).where('day_performed >= ?', first).where('day_performed <= ?', last)
  end

  def self.get_matching_routines(routine)
    DailyRoutine.where(:wt_day_id => routine.wt_day_id, :sp_day_id => routine.sp_day_id, :pl_day_id => routine.pl_day_id,
                       :wu_day_id => routine.wu_day_id, :user_id => routine.user.id).order(id: :desc)
  end

  def self.get_open_workouts_start_today(entity)
    now = Date.today
    DailyRoutine.where(:user_id => entity.id, :closed => false).where('day_performed >= ?', now)
  end

  def self.get_open_workouts(entity)
    now = Date.today
    DailyRoutine.where(:user_id => entity.id, :closed => false).where('day_performed > ?', now)
  end

  def self.has_open_workout_today(entity)
    now = Date.today
    workouts = DailyRoutine.where(:user_id => entity.id, :closed => false, :day_performed => now)
    workouts.size > 0
  end

  def self.has_closed_workout(entity, date)
    workouts = DailyRoutine.where(:user_id => entity.id, :closed => true, :day_performed => date)
    workouts.size > 0
  end

  def get_workout_status
    if self.closed
      return 'closed'
    end

    'active'
  end

  def self.get_routine_by_date(month, year, day, user_id)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    DailyRoutine.where(day_performed: date, user_id: user_id).first
  end

  def self.create_routine(user_id, date, group_routine_id)
    #There are no checks at this point to see if the workout we're deleting is a closed workout.
    #If this check needs to be made, it's done above this level
    old_routine = DailyRoutine.where(day_performed: date, user_id: user_id).first
    if !old_routine.nil?
      old_routine.destroy
    end
    return DailyRoutine.create(user_id: user_id, day_performed: date, group_routine_id: group_routine_id)
  end

  def self.get_matching_routine_since(date, type, day_id, user_id)
    matching = nil
    case type
      when STRETCHING
        matching = DailyRoutine.where(:user_id => user_id).where('day_performed > ?', date).where(:wu_day_id => day_id).order(day_performed: :desc).first
      when WEIGHTS
        matching = DailyRoutine.where(:user_id => user_id).where('day_performed > ?', date).where(:wt_day_id => day_id).order(day_performed: :desc).first
      when PLYOS
        matching = DailyRoutine.where(:user_id => user_id).where('day_performed > ?', date).where(:pl_day_id => day_id).order(day_performed: :desc).first
      when SPRINTING
        matching = DailyRoutine.where(:user_id => user_id).where('day_performed > ?', date).where(:sp_day_id => day_id).order(day_performed: :desc).first
    end
    matching
  end

  def note_warmup_changes_saved
    self.wu_modified = true
    self.changes_saved = true
    self.save
  end

  def note_plyometric_changes_saved
    self.pl_modified = true
    self.changes_saved = true
    self.save
  end

  def note_sprint_changes_saved
    self.changes_saved = true
    self.sp_modified = true
    self.save
  end

  def note_weight_changes_saved
    self.changes_saved = true
    self.wt_modified = true
    self.save
  end

  def self.get_routine_from_group_routine_id(routine_id, group_id, user_id)
    DailyRoutine.where(:group_routine_id => routine_id, :group_id => group_id, :user_id => user_id).first
  end

  def get_warmups_without_changes_saved
    self.performed_warm_ups.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_plyometrics_without_changes_saved
    self.performed_plyometrics.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_sprints_without_changes_saved
    self.performed_sprints.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_weights_without_changes_saved
    self.performed_exercises.where('status == 2 or status == 3').order(id: :asc)
  end

  def add_warmup(exercise_id, status, group_performed_ex_id)
    self.performed_warm_ups << PerformedWarmUp.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
  end

  def add_plyometric(exercise_id, status, group_performed_ex_id)
    self.performed_plyometrics << PerformedPlyometric.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
  end

  def add_sprint(exercise_id, status, group_performed_ex_id)
    sprint = PerformedSprint.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
    self.performed_sprints << sprint
    num_laps = sprint.sprint.num_laps
    for i in 1..num_laps
      Lap.create_lap(sprint.id, i)
    end
  end

  def add_weights(exercise, status, group_performed_ex_id)
    perf_exercise = PerformedExercise.add_exercise(exercise.id, status, self.id, exercise.exercise_type.id, group_performed_ex_id)
    self.performed_exercises << perf_exercise
    weight_set_service = WeightSetService.new(self.user, self, perf_exercise)
    weight_set_service.create_sets
  end

  def note_day_created(day_id, type)
    case type
      when STRETCHING
        self.wu_day_id = day_id
      when WEIGHTS
        self.wt_day_id = day_id
      when PLYOS
        self.pl_day_id = day_id
      when SPRINTING
        self.sp_day_id = day_id
    end
    self.save
  end

  def add_custom_exercise(name, type, group_performed_id)
    self.custom_exercises << CustomExercise.add_exercise(self.id, name, type, group_performed_id)
  end

  def has_plyo(exercise)
    contains = false
    self.performed_plyometrics.each do |plyo|
      if plyo.plyometric.id == exercise.id
        contains = true
        break
      end
    end
    contains
  end

end
