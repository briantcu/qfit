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
  belongs_to :group
  has_many :group_performed_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_plyos, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_sprints, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_performed_warmups, -> { order('id ASC') }, :foreign_key => :routine_id
  has_many :group_custom_exercises, -> { order('id ASC') }, :foreign_key => :routine_id
end
