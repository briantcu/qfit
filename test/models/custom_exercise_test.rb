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
#  ex_type    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CustomExerciseTest < ActiveSupport::TestCase
  test 'should add exercise' do
    exercise = CustomExercise.add_exercise(3, 'test', 4, 3)
    assert(exercise != nil)
  end
end
