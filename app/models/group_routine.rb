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
  has_many :group_performed_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_plyos, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_sprints, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_warmups, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_custom_exercises, -> { order('id ASC') }, :foreign_key => :routine_id


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
    if !old_routine.nil?
      old_routine.destroy
    end
    return GroupRoutine.create(group_id: group_id, day_performed: date)
  end

  def note_warmup_changes_saved
    self.changes_saved = true
    self.wu_modified = true
    self.save
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        user_routine.note_warmup_changes_saved
      end
    end
  end

  def note_plyometric_changes_saved
    self.pl_modified = true
    self.changes_saved = true
    self.save
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        user_routine.note_plyometric_changes_saved
      end
    end
  end

  def get_warmups_without_changes_saved
    self.group_performed_warmups.where('status == 2 or status == 3').order(id: :asc)
  end

  def add_warmup(exercise_id, status, not_used)
    exercise = GroupPerformedWarmup.add_exercise(exercise_id, status, self.id)
    self.group_performed_warmups << exercise
    add_for_users(PerformedWarmUp, exercise, exercise_id)
    exercise
  end

  def add_plyometric(exercise_id, status, not_used)
    exercise = GroupPerformedPlyo.add_exercise(exercise_id, status, self.id)
    self.group_performed_plyos << exercise
    add_for_users(PerformedPlyometric, exercise, exercise_id)
    exercise
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
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        user_routine.add_custom_exercise(name, type, group_exercise.id)
      end
    end
  end

  def has_plyo(exercise)
    contains = false
    self.group_performed_plyos.each do |plyo|
      if plyo.plyometric.id == exercise.id
        contains = true
        break
      end
    end
    contains
  end

  private

  def add_for_users(performed_entity, exercise, exercise_id)
    self.group.users.each do |user|
      user_routine = DailyRoutine.get_routine_from_group_routine_id(self.id, self.group.id, user.id)
      if !user_routine.nil?
        performed_entity.add_exercise(exercise_id, exercise.status, user_routine.id, exercise.id)
      end
    end
  end

end
