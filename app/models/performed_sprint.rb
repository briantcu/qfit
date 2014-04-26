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
end
