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

  def self.get_routine_by_date(month, year, day)
    date = DateTime.new(year.to_i, month.to_i, day.to_i)
    DailyRoutine.where(day_performed: date).first
  end

end
