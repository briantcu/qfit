require 'singleton'

class ExerciseValidatorService
  include Singleton

  def is_valid_plyo(entity, routine, exercise)
    if routine.has_plyo?(exercise)
      return false
    end

    true
  end

  def is_valid_exercise(entity, routine, exercise)

    #@TODO
    #equipment
    #experience
    #strength level

    if matches_user_strength_level(entity, exercise)
      return true
    else
      return false
    end

  end

  private

  def matches_user_strength_level(entity, exercise)
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
          when 64 #Side to side jacknife push up
            valid = (pi_to_weight > 0.048)
          when 69 #Jacknife push up
            valid = (pi_to_weight > 0.038)
          when 82 #Side to side pullup
            valid = (pi_to_weight > 0.14)
          when 84 #chinup
            valid = (pi_to_weight > 0.11)
          when 86 #Wide grip pullup
            valid = (pi_to_weight > 0.124)
          when 119 #power pushups
            valid = (pi_to_weight > 0.11)
          when 120 #Assisted pushup
            valid = (pi_to_weight < 0.041)
          when 54 #assisted pullup
            valid = (pi_to_weight < 0.11)
          when 132 #assisted chinup
            valid = (pi_to_weight < 0.11)
          when 133 #assisted wide grip pullup
            valid = (pi_to_weight < 0.13)
          when 134 #pullups with weight belt
            valid = (pi_to_weight > 0.128)
          when 135 #chinups with weight belt
            valid = (pi_to_weight > 0.128)
          when 136 #wide grip pullups with weight belt
            valid = (pi_to_weight > 0.15)
          when 58 # assisted dips
            valid = (pi_to_weight < 0.053)
          when 59 #dips with weight belt
            valid = (pi_to_weight > 0.064)
        end
      end
    else
      valid = true
    end
    valid
  end

end