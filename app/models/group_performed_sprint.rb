# == Schema Information
#
# Table name: group_performed_sprints
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  status     :integer
#  routine_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedSprint < ActiveRecord::Base
  belongs_to :group_routine
end
