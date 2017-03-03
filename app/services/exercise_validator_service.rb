require 'singleton'

class ExerciseValidatorService
  include Singleton

  def is_valid_plyo(entity, routine, exercise)
    if routine.has_plyo?(exercise)
      return false
    end

    true
  end

  def is_valid_warmup(entity, routine, exercise)
    if routine.has_warmup?(exercise)
      return false
    end

    true
  end

  def is_valid_exercise(entity, routine, exercise)

    if matches_user_strength_level?(entity, exercise)
      return true
    else
      return false
    end

  end

  private

  def matches_user_strength_level?(entity, exercise)
    if entity.is_group?
      return true
    end

    valid = false
    if exercise.is_body_weight
      if entity.power_index != 0
        pi_to_weight = entity.power_index.to_f / entity.weight.to_f
        case exercise.id
          when 55 #Decline push up
            valid = (pi_to_weight > 0.038)
          when 53 #Push up
            valid = (pi_to_weight > 0.047)
          when 56 #Incline push up
            valid = (pi_to_weight > 0.038)
          when 57 #Dips
            valid = (pi_to_weight > 0.053)
          when 63 #Side to side jacknife push up
            valid = (pi_to_weight > 0.048)
          when 68 #Jacknife push up
            valid = (pi_to_weight > 0.038)
          when 81 #Side to side pullup
            valid = (pi_to_weight > 0.14)
          when 83 #chinup
            valid = (pi_to_weight > 0.11)
          when 84 #pullup
            valid = (pi_to_weight > 0.11)
          when 85 #Wide grip pullup
            valid = (pi_to_weight > 0.124)
          when 118 #power pushups
            valid = (pi_to_weight > 0.11)
          when 119 #Assisted pushup
            valid = (pi_to_weight < 0.041)
          when 54 #assisted pullup
            valid = (pi_to_weight < 0.11)
          when 131 #assisted chinup
            valid = (pi_to_weight < 0.11)
          when 132 #assisted wide grip pullup
            valid = (pi_to_weight < 0.13)
          when 133 #pullups with weight belt
            valid = (pi_to_weight > 0.25)
          when 134 #chinups with weight belt
            valid = (pi_to_weight > 0.25)
          when 135 #wide grip pullups with weight belt
            valid = (pi_to_weight > 0.30)
          when 58 # assisted dips
            valid = (pi_to_weight < 0.053)
          when 59 #dips with weight belt
            valid = (pi_to_weight > 0.14)
        end
      end
    else
      valid = true
    end
    valid
  end

end