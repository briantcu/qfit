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
end
