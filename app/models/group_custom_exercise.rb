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

class GroupCustomExercise < ActiveRecord::Base
  belongs_to :group_routine


  def self.add_exercise(routine_id, name, type)
    GroupCustomExercise.create(routine_id: routine_id, name: name, ex_type: type)
  end

  def destroy_ex
    get_user_exes.each do |ex|
      ex.destroy
    end
    self.destroy
  end

  private

  def get_user_exes
    CustomExercise.where(group_id: self.id)
  end
end
