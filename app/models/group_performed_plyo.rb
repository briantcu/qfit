# == Schema Information
#
# Table name: group_performed_plyos
#
#  id            :integer          not null, primary key
#  plyometric_id :integer
#  routine_id    :integer
#  status        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class GroupPerformedPlyo < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :plyometric

  def self.add_exercise(exercise_id, status, routine_id)
    GroupPerformedPlyo.create(routine_id: routine_id, plyometric_id: exercise_id, status: status)
  end
end
