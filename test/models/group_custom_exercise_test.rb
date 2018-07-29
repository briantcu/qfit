# == Schema Information
#
# Table name: group_custom_exercises
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  details    :text
#  status     :integer
#  name       :string(255)
#  ex_type    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class GroupCustomExerciseTest < ActiveSupport::TestCase
  test 'should add exercise' do
    exercise = GroupCustomExercise.add_exercise(3, 'test', 4)
    assert(exercise != nil)
  end
end
