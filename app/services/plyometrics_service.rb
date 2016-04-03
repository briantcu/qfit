require 'singleton'

class PlyometricsService
  include Singleton


  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  @entity
  @routine


  def add_exercises(entity, routine)
    @entity = entity
    @routine = routine
    if @entity.is_group?
      plyos = Plyometric.all
    else
      plyos = Plyometric.where('paid_tier <= ?', @entity.paid_tier)
    end
    num_plyos_for_index = plyos.count - 1

    (0..3).each do |i|
      while true
        index = rand(0..(num_plyos_for_index))
        plyo = plyos.at(index)
        if ExerciseValidatorService.instance.is_valid_plyo(@entity, @routine, plyo)
          @routine.add_plyometric(plyo.id, 3, 0)
          break
        end
      end
    end
  end

  def copy_exercises(entity, routine, previous_routine)
    @entity = entity
    @routine = routine

    if previous_routine.changes_saved && previous_routine.pl_modified
      if entity.is_group
        previous_exercises = previous_routine.group_performed_plyos
      else
        previous_exercises = previous_routine.performed_plyometrics
      end
      @routine.note_plyometric_changes_saved
    else
      previous_exercises = previous_routine.get_plyometrics_without_changes_saved
    end

    previous_exercises.each do |exercise|
      status = exercise.status
      #If changes were not saved, make invisible default exercises visible.
      if !previous_routine.changes_saved
        if status == 2
          status = 3
        end
      end
      @routine.add_plyometric(exercise.id, status, 0) #0 = group performed exercise id
    end

    if previous_routine.changes_saved && previous_routine.pl_modified
      #copy custom exercises
      previous_routine.get_custom_exercises(PLYOS).each do |exercise|
        @routine.add_custom_exercise(exercise.name, PLYOS, 0)
      end
    end

  end
end