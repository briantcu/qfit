# == Schema Information
#
# Table name: group_custom_exercises
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  details    :text
#  status     :integer
#  name       :string(255)
#  type       :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupCustomExercise < ActiveRecord::Base
  belongs_to :group_routine
end
