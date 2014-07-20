# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  type_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ExerciseType < ActiveRecord::Base
  has_many :exercises

  def get_exercises
    if self.id == 14
      return Exercise.where('exercise_type_id == 14 or exercise_type_id == 15 or exercise_type_id == 16')
    else
      return self.exercises
    end
  end

  def as_json(options={})
    super(:include =>[:exercises])
  end
end
