# == Schema Information
#
# Table name: group_routines
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  day_performed  :date
#  program_day_id :integer
#  wt_day_id      :integer
#  sp_day_id      :integer
#  pl_day_id      :integer
#  wu_day_id      :integer
#  modified       :boolean
#  pl_modified    :boolean
#  wt_modified    :boolean
#  wu_modified    :boolean
#  sp_modified    :boolean
#  changes_saved  :boolean
#  created_at     :datetime
#  updated_at     :datetime
#

class GroupRoutine < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3


  belongs_to :group
  has_many :group_performed_exercises, -> { order('id ASC') }, :foreign_key => :routine_id, dependent: :destroy
  has_many :group_performed_plyos, -> { order('id ASC') }, :foreign_key => :routine_id, dependent: :destroy
  has_many :group_performed_sprints, -> { order('id ASC') }, :foreign_key => :routine_id, dependent: :destroy
  has_many :group_performed_warmups, -> { order('id ASC') }, :foreign_key => :routine_id, dependent: :destroy
  has_many :group_custom_exercises, -> { order('id ASC') }, :foreign_key => :routine_id, dependent: :destroy

  def self.get_routine_by_date(month, year, day, group_id)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    GroupRoutine.where(day_performed: date, group_id: group_id).first
  end


  def get_warmups
    self.group_performed_warmups
  end

  def get_weights
    self.group_performed_exercises
  end

  def get_sprints
    self.group_performed_sprints
  end

  def get_plyos
    self.group_performed_plyos
  end

  def get_custom_exercises(type)
    case type
      when STRETCHING
        return self.group_custom_exercises.where(exercise_types: STRETCHING)
      when WEIGHTS
        return self.group_custom_exercises.where(exercise_types: WEIGHTS)
      when PLYOS
        return self.group_custom_exercises.where(exercise_types: PLYOS)
      when SPRINTING
        return self.group_custom_exercises.where(exercise_types: SPRINTING)
    end
  end

  def self.get_open_workouts_start_today(entity)
    now = Date.today
    GroupRoutine.where(:group_id => entity.id).where('day_performed >= ?', now)
  end

  def self.get_open_workouts(entity)
    now = Date.today
    GroupRoutine.where(:group_id => entity.id).where('day_performed > ?', now)
  end

  def self.get_matching_routine_since(date, type, day_id, group_id)
    matching = nil
    case type
      when STRETCHING
        matching = GroupRoutine.where(:group_id => group_id).where('day_performed > ?', date).where(:wu_day_id => day_id).order(day_performed: :desc).first
      when WEIGHTS
        matching = GroupRoutine.where(:group_id => group_id).where('day_performed > ?', date).where(:wt_day_id => day_id).order(day_performed: :desc).first
      when PLYOS
        matching = GroupRoutine.where(:group_id => group_id).where('day_performed > ?', date).where(:pl_day_id => day_id).order(day_performed: :desc).first
      when SPRINTING
        matching = GroupRoutine.where(:group_id => group_id).where('day_performed > ?', date).where(:sp_day_id => day_id).order(day_performed: :desc).first
    end
    matching
  end

  def self.create_routine(group_id, date)
    old_routine = GroupRoutine.where(day_performed: date, group_id: group_id).first
    unless old_routine.blank?
      old_routine.destroy
    end
    return GroupRoutine.create(group_id: group_id, day_performed: date)
  end

  def self.get_matching_routines(routine)
    GroupRoutine.where(:wt_day_id => routine.wt_day_id, :sp_day_id => routine.sp_day_id, :pl_day_id => routine.pl_day_id, :wu_day_id => routine.wu_day_id, :group_id => routine.group.id).order(id: :desc)
  end

  def copy_to_user(user)
    DailyRoutine.create_routine(user.id, self.day_performed, self.id)
    self.group_performed_warmups.each do |gpw|
      add_for_user(STRETCHING, gpw, gpw.warmup_id, user)
    end

    self.group_performed_plyos.each do |gpp|
      add_for_user(PLYOS, gpp, gpp.plyometric_id, user)
    end

    self.group_performed_sprints.each do |gps|
      add_for_user(SPRINTING, gps, gps.sprint_id, user)
    end

    self.group_performed_exercises.each do |gpe|
      add_for_user(WEIGHTS, gpe, gpe.exercise_id, user)
    end

    self.group_custom_exercises.each do |c|
      add_custom_for_user(c, c.ex_type, user)
    end
  end

  def note_warmup_changes_saved
    self.changes_saved = true
    note_warmups_changed(false) #changes will be noted for users when we note changes saved
    note_changes_saved_for_users(STRETCHING)
  end

  def note_sprint_changes_saved
    self.changes_saved = true
    note_sprints_changed(false) #changes will be noted for users when we note changes saved
    note_changes_saved_for_users(SPRINTING)
  end

  def note_plyometric_changes_saved
    self.changes_saved = true
    note_plyos_changed(false) #changes will be noted for users when we note changes saved
    note_changes_saved_for_users(PLYOS)
  end

  def note_weight_changes_saved
    self.changes_saved = true
    note_weights_changed(false) #changes will be noted for users when we note changes saved
    note_changes_saved_for_users(WEIGHTS)
  end

  def note_warmups_changed(note_for_users)
    self.wu_modified = true
    self.modified = true
    self.save
    if note_for_users
      note_changes_for_users(STRETCHING)
    end
  end

  def note_plyos_changed(note_for_users)
    self.pl_modified = true
    self.modified = true
    self.save
    if note_for_users
      note_changes_for_users(PLYOS)
    end
  end

  def note_sprints_changed(note_for_users)
    self.sp_modified = true
    self.modified = true
    self.save
    if note_for_users
      note_changes_for_users(SPRINTING)
    end
  end

  def note_weights_changed(note_for_users)
    self.modified = true
    self.wt_modified = true
    self.save
    if note_for_users
      note_changes_for_users(WEIGHTS)
    end
  end


  def get_warmups_without_changes_saved
    self.group_performed_warmups.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_sprints_without_changes_saved
    self.group_performed_sprints.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_plyometrics_without_changes_saved
    self.group_performed_plyos.where('status == 2 or status == 3').order(id: :asc)
  end

  def get_weights_without_changes_saved
    self.group_performed_exercises.where('status == 2 or status == 3').order(id: :asc)
  end

  def add_warmup(exercise_id, status, not_used)
    exercise = GroupPerformedWarmup.add_exercise(exercise_id, status, self.id)
    self.group_performed_warmups << exercise
    add_for_users(STRETCHING, exercise, exercise_id)
    exercise
  end

  def add_plyometric(exercise_id, status, not_used)
    exercise = GroupPerformedPlyo.add_exercise(exercise_id, status, self.id)
    self.group_performed_plyos << exercise
    add_for_users(PLYOS, exercise, exercise_id)
    exercise
  end

  def add_sprint(exercise_id, status, not_used)
    exercise = GroupPerformedSprint.add_exercise(exercise_id, status, self.id)
    self.group_performed_sprints << exercise
    add_for_users(SPRINTING, exercise, exercise_id)
    exercise
  end

  def add_weights(exercise, status, not_used)
    perf_exercise = GroupPerformedExercise.add_exercise(exercise.id, status, self.id, exercise.exercise_type.id)
    self.group_performed_exercises << perf_exercise
    add_for_users(WEIGHTS, perf_exercise, exercise.id)
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
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        user_routine.note_day_created(day_id, type)
      end
    end
  end

  def add_custom_exercise(name, type, not_used)
    group_exercise = GroupCustomExercise.add_exercise(self.id, name, type)
    self.group_custom_exercises << group_exercise
    self.group.users.each do |user|
      add_custom_for_user(group_exercise, user)
    end
    case type
      when STRETCHING
        note_warmups_changed(true)
      when WEIGHTS
        note_weights_changed(true)
      when PLYOS
        note_plyos_changed(true)
      when SPRINTING
        note_sprints_changed(true)
    end
  end

  def add_custom_for_user(group_exercise, user)
    user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
    if !user_routine.nil?
      user_routine.add_custom_exercise(group_exercise.name, group_exercise.ex_type, group_exercise.id)
    end
  end

  def has_plyo?(exercise)
    contains = false
    self.group_performed_plyos.each do |plyo|
      if plyo.plyometric.id == exercise.id
        contains = true
        break
      end
    end
    contains
  end

  def self.has_open_workout_today?(entity)
    now = Date.today
    workouts = GroupRoutine.where(:group_id => entity.id, :day_performed => now)
    workouts.size > 0
  end

  def reset
    #Set all exercises with status == 2 (deleted) to 3 (provided, unmodified)
    exes = self.group_performed_exercises.where(status: 2)
    reset_exercises(exes)
    exes = self.group_performed_warmups.where(status: 2)
    reset_exercises(exes)
    exes = self.group_performed_plyos.where(status: 2)
    reset_exercises(exes)
    exes = self.group_performed_sprints.where(status: 2)
    reset_exercises(exes)

    #Delete all exercises with status == 1 (added or custom)
    exes = self.group_performed_exercises.where(status: 1)
    destroy_exercises(exes)
    exes = self.group_performed_warmups.where(status: 1)
    destroy_exercises(exes)
    exes = self.group_performed_plyos.where(status: 1)
    destroy_exercises(exes)
    exes = self.group_performed_sprints.where(status: 1)
    destroy_exercises(exes)
    exes = self.group_custom_exercises.where(status: 1)
    destroy_exercises(exes)

    #Reset modified flags
    self.modified = false
    self.pl_modified = false
    self.wt_modified = false
    self.wu_modified = false
    self.sp_modified = false
    self.save

    DailyRoutine.where(group_routine_id: self.id).each do |routine|
      routine.reset
    end

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

  def add_for_users(type, exercise, exercise_id)
    self.group.users.each do |user|
      add_for_user(type, exercise, exercise_id, user)
    end
  end

  def add_for_user(type, exercise, exercise_id, user)
    user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
    unless user_routine.nil?
      case type
        when STRETCHING
          user_routine.add_warmup(exercise_id, exercise.status, exercise.id)
        when PLYOS
          user_routine.add_plyometric(exercise_id, exercise.status, exercise.id)
        when SPRINTING
          user_routine.add_sprint(exercise_id, exercise.status, exercise.id)
        else
          user_routine.add_weights(exercise_id, exercise.status, exercise.id)
      end
    end
  end

  def note_changes_saved_for_users(type)
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        case type
          when STRETCHING
            user_routine.note_warmup_changes_saved
          when WEIGHTS
            user_routine.note_weight_changes_saved
          when PLYOS
            user_routine.note_plyometric_changes_saved
          when SPRINTING
            user_routine.note_sprint_changes_saved
        end
      end
    end
  end

  def note_changes_for_users(type)
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        case type
          when STRETCHING
            user_routine.note_warmups_changed
          when WEIGHTS
            user_routine.note_weights_changed
          when PLYOS
            user_routine.note_plyos_changed
          when SPRINTING
            user_routine.note_sprints_changed
        end
      end
    end
  end


end
