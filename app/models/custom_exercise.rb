# == Schema Information
#
# Table name: custom_exercises
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  details    :string(255)
#  status     :integer
#  group_id   :integer
#  name       :string(255)
#  type       :integer
#  created_at :datetime
#  updated_at :datetime
#

class CustomExercise < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
end
