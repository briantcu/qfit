# == Schema Information
#
# Table name: performed_sprints
#
#  id                        :integer          not null, primary key
#  sprint_id                 :integer
#  status                    :integer
#  group_performed_sprint_id :integer
#  routine_id                :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class PerformedSprint < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :sprint
  belongs_to :group_performed_sprint
  has_many :laps, -> { order('id ASC') }
  accepts_nested_attributes_for :laps, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
end
