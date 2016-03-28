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

  def get_exercises(experience_level = 3, paid_tier)
    #Experience level is 1-3
    paid_tier ||= 1000
    if self.id == 14
      Exercise.where('exercise_type_id = 14 or exercise_type_id = 15 or exercise_type_id = 16')
          .where('difficulty <= ?', experience_level).where('paid_tier <= ', paid_tier)
    else
      self.exercises.where('difficulty <= ?', experience_level).where('paid_tier <= ', paid_tier)
    end
  end

  def as_json(options={})
    super(:include =>[:exercises])
  end
end
