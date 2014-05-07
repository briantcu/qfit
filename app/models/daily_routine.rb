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
  has_many :custom_exercises, :foreign_key => :routine_id
  has_many :performed_exercises, :foreign_key => :routine_id
  has_many :performed_plyometrics, :foreign_key => :routine_id
  has_many :performed_sprints, :foreign_key => :routine_id
  has_many :performed_warm_ups, :foreign_key => :routine_id

  accepts_nested_attributes_for :custom_exercises, allow_destroy: true
  accepts_nested_attributes_for :performed_warm_ups, allow_destroy: true
  accepts_nested_attributes_for :performed_exercises, allow_destroy: true
  accepts_nested_attributes_for :performed_plyometrics, allow_destroy: true
  accepts_nested_attributes_for :performed_sprints, allow_destroy: true
end
