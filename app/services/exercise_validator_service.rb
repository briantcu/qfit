class ExerciseValidatorService


  def self.is_valid_plyo(entity, routine, exercise)
    if routine.has_plyo(exercise)
      return false
    end

    true
  end



end