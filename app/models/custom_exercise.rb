# == Schema Information
#
# Table name: custom_exercises
#
#  id         :integer          not null, primary key
#  rid        :integer
#  details    :string(255)
#  status     :integer
#  gid        :integer
#  name       :string(255)
#  type       :integer
#  created_at :datetime
#  updated_at :datetime
#

class CustomExercise < ActiveRecord::Base
end
