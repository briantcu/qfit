# == Schema Information
#
# Table name: group_performed_warmups
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  warmup_id  :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedWarmup < ActiveRecord::Base
  belongs_to :group_routine


  def self.add_exercise(exercise_id, status, routine_id)
      GroupPerformedWarmup.create(routine_id: routine_id, warmup_id: exercise_id, status: status)
  end
end
