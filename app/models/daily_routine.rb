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

  def self.get_routines_for_month(user_id, month, year)
    first = Date.new(year, month, 1)
    last = first.end_of_month
    DailyRoutine.where(:user_id => user_id).where('day_performed >= ?', first).where('day_performed <= ?', last)
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

  def self.create_routine(user_id, date)
    old_routine = DailyRoutine.where(day_performed: date, user_id: user_id).first
    if !old_routine.nil?
      old_routine.destroy
    end
    return DailyRoutine.create(user_id: user_id, day_performed: date)
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

  def self.get_routine_from_group_routine_id(routine_id, group_id, user_id)
    DailyRoutine.where(:group_routine_id => routine_id, :group_id => group_id, :user_id => user_id).first
  end

  def get_warmups_without_changes_saved
    self.performed_warm_ups.where('status == 2 or status == 3').order(id: :asc)
  end

  def add_warmup(exercise_id, status, group_performed_ex_id)
    PerformedWarmUp.add_exercise(exercise_id, status, self.id, group_performed_ex_id)
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
    CustomExercise.add_exercise(self.id, name, type, group_performed_id)
  end

end
