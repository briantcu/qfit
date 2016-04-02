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
#  shared             :boolean          default(FALSE)
#

class DailyRoutine < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  validates :day_performed, presence: true

  scope :completed, -> {where('closed = 1 and count_ex_completed  > 0')}
  scope :open, -> {where(closed: false)}
  scope :closed_since, -> (date) {where('closed = 1 and day_performed > ?', date)}

  belongs_to :user
  has_many :custom_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_plyometrics, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_sprints, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :performed_warm_ups, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :routine_messages, :foreign_key => :daily_routine_id

  accepts_nested_attributes_for :custom_exercises, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_warm_ups, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_exercises, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_plyometrics, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  accepts_nested_attributes_for :performed_sprints, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def completed?
    self.closed && (self.count_ex_completed > 0)
  end

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
    DailyRoutine.where(:user_id => entity.id, :closed => false).where('day_performed >= ?', now).order(day_performed: :asc)
  end

  def self.get_open_workouts(entity)
    now = Date.today
    DailyRoutine.where(:user_id => entity.id, :closed => false).where('day_performed > ?', now)
  end

  def self.has_open_workout_today?(entity)
    now = Date.today
    workouts = DailyRoutine.where(:user_id => entity.id, :closed => false, :day_performed => now)
    workouts.count > 0
  end

  def self.get_old_open_workouts_for_user(user_id)
    now = Date.today
    workouts = DailyRoutine.where(:user_id => user_id, :closed => false).where('day_performed < ?', now)
    workouts
  end

  def self.has_closed_workout?(entity, date)
    workouts = DailyRoutine.where(:user_id => entity.id, :closed => true, :day_performed => date)
    workouts.count > 0
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

  def self.create_routine(user_id, date, group_routine_id, override_current = true)
    #There are no checks at this point to see if the workout we're deleting is a closed workout.
    #If this check needs to be made, it's done above this level
    if override_current
      old_routine = DailyRoutine.where(day_performed: date, user_id: user_id).first
      unless old_routine.blank?
        old_routine.destroy
      end
    end

    return DailyRoutine.find_or_create_by(user_id: user_id, day_performed: date, group_routine_id: group_routine_id)
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
    self.changes_saved = true
    note_warmups_changed
  end

  def note_warmups_changed
    self.wu_modified = true
    self.modified = true
    self.save
  end

  def note_plyometric_changes_saved
    self.changes_saved = true
    note_plyos_changed
  end

  def note_plyos_changed
    self.pl_modified = true
    self.modified = true
    self.save
  end

  def note_sprint_changes_saved
    self.sp_modified = true
    note_sprints_changed
  end

  def note_sprints_changed
    self.sp_modified = true
    self.modified = true
    self.save
  end

  def note_weight_changes_saved
    self.changes_saved = true
    note_weights_changed
  end

  def note_weights_changed
    self.modified = true
    self.wt_modified = true
    self.save
  end

  def self.get_routine_from_group_routine_id(routine_id, group_id, user_id)
    DailyRoutine.where(:group_routine_id => routine_id, :group_id => group_id, :user_id => user_id).first
  end

  def get_warmups_without_changes_saved
    self.performed_warm_ups.where('status = 2 or status = 3').order(id: :asc)
  end

  def get_plyometrics_without_changes_saved
    self.performed_plyometrics.where('status = 2 or status = 3').order(id: :asc)
  end

  def get_sprints_without_changes_saved
    self.performed_sprints.where('status = 2 or status = 3').order(id: :asc)
  end

  def get_weights_without_changes_saved
    self.performed_exercises.where('status = 2 or status = 3').order(id: :asc)
  end

  def add_warmup(exercise_id, status, group_performed_ex_id)
    perf_wu = PerformedWarmUp.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
    self.performed_warm_ups << perf_wu
    perf_wu
  end

  def add_plyometric(exercise_id, status, group_performed_ex_id)
    perf_plyo = PerformedPlyometric.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
    self.performed_plyometrics << perf_plyo
    perf_plyo
  end

  def add_sprint(exercise_id, status, group_performed_ex_id)
    sprint = PerformedSprint.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
    self.performed_sprints << sprint
    num_laps = sprint.sprint.num_laps
    for i in 1..num_laps
      sprint.laps << Lap.create_lap(sprint.id, i)
    end
    sprint
  end

  def add_weights(exercise, status, group_performed_ex_id)
    perf_exercise = PerformedExercise.add_exercise(exercise.id, status, self.id, exercise.exercise_type.id, group_performed_ex_id)
    self.performed_exercises << perf_exercise
    weight_set_service = WeightSetService.new(self.user, self, perf_exercise)
    weight_set_service.create_sets
    perf_exercise
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
    case type
      when STRETCHING
        note_warmups_changed
      when WEIGHTS
        note_weights_changed
      when PLYOS
        note_plyos_changed
      when SPRINTING
        note_sprints_changed
    end
    self.custom_exercises << CustomExercise.add_exercise(self.id, name, type, group_performed_id)
  end

  def has_plyo?(exercise)
    contains = false
    self.performed_plyometrics.each do |plyo|
      if plyo.plyometric.id == exercise.id
        contains = true
        break
      end
    end
    contains
  end

  def get_num_completed_plyos
    completed_plyos = 0
    perf_plyos = self.performed_plyometrics.where('status = 1 or status = 3')
    perf_plyos.each do |perf_plyo|
      completed_plyos = (perf_plyo.performed_one && (((perf_plyo.status == 1)) || (perf_plyo.status == 3))) ?
          completed_plyos + 1 : completed_plyos
      completed_plyos = (perf_plyo.performed_two && (((perf_plyo.status == 1)) || (perf_plyo.status == 3))) ?
          completed_plyos + 1 : completed_plyos
      completed_plyos = (perf_plyo.performed_three && (((perf_plyo.status == 1)) || (perf_plyo.status == 3))) ?
          completed_plyos + 1 : completed_plyos
    end
    completed_plyos
  end

  def get_num_completed_weight_sets
    total_sets = 0
    perf_exes = self.performed_exercises.where('status = 1 or status = 3')
    perf_exes.each do |ex|
      total_sets = total_sets + ex.weight_sets.where('perf_reps != 0').count
    end
    total_sets
  end

  def get_num_completed_laps
    total_laps = 0
    perf_sprints = self.performed_sprints.where('status = 1 or status = 3')
    perf_sprints.each do |sprint|
      total_laps = total_laps + sprint.laps.where(:completed => true).count
    end
    total_laps
  end

  def get_num_completed_warmups
    self.performed_warm_ups.where('status = 1 or status = 3').where(:completed => true).count
  end

  def get_num_provided_plyos
    perf_plyos = self.performed_plyometrics.where('status = 1 or status = 3')
    perf_plyos.count * 3
  end

  def get_num_provided_weight_sets
    total_sets = 0
    perf_exes = self.performed_exercises.where('status = 1 or status = 3')
    perf_exes.each do |ex|
      total_sets = total_sets + ex.weight_sets.count
    end
    total_sets
  end

  def get_num_provided_laps
    total_laps = 0
    perf_sprints = self.performed_sprints.where('status = 1 or status = 3')
    perf_sprints.each do |sprint|
      total_laps = total_laps + sprint.laps.count
    end
    total_laps
  end

  def get_num_provided_warmups
    self.performed_warm_ups.where('status = 1 or status = 3').count
  end

  def reset
    #Set all exercises with status == 2 (deleted) to 3 (provided, unmodified)
    exes = self.performed_exercises.where(status: 2)
    reset_exercises(exes)
    exes = self.performed_warm_ups.where(status: 2)
    reset_exercises(exes)
    exes = self.performed_plyometrics.where(status: 2)
    reset_exercises(exes)
    exes = self.performed_sprints.where(status: 2)
    reset_exercises(exes)

    #Delete all exercises with status == 1 (added or custom)
    exes = self.performed_exercises.where(status: 1)
    destroy_exercises(exes)
    exes = self.performed_warm_ups.where(status: 1)
    destroy_exercises(exes)
    exes = self.performed_plyometrics.where(status: 1)
    destroy_exercises(exes)
    exes = self.performed_sprints.where(status: 1)
    destroy_exercises(exes)
    exes = self.custom_exercises.where(status: 1)
    destroy_exercises(exes)

    #Reset modified flags
    self.modified = false
    self.pl_modified = false
    self.wt_modified = false
    self.wu_modified = false
    self.sp_modified = false
    self.save
    self
  end

  private

  def reset_exercises(exes)
    exes.each do |ex|
      ex.status = 3
      ex.save
    end
  end

  def destroy_exercises(exes)
    exes.each do |ex|
      ex.destroy
    end
  end
end
