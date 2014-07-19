# == Schema Information
#
# Table name: user_maxes
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  user_id     :integer
#  max         :float
#  created_at  :datetime
#  updated_at  :datetime
#

class UserMax < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  def self.get_max(user_id, exercise_id)
    UserMax.where(:user_id => user_id, :exercise_id => exercise_id).first
  end

  def self.set_max(user_id, exercise_id, max)
    user_max = get_max(user_id, exercise_id)
    if user_max.nil?
      UserMax.create(exercise_id: exercise_id, max: max, user_id: user_id)
    else
      user_max.max = max
      user_max.save
    end
  end
end
