# == Schema Information
#
# Table name: tips
#
#  id            :integer          not null, primary key
#  exercise_type :integer
#  tip           :text
#  exercise_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Tip < ActiveRecord::Base

  def self.for_exercise(type, id)
    where('exercise_type = :type and exercise_id = :id', type: type, id: id)
  end
end
