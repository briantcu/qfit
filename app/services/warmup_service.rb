require 'singleton'

class WarmupService
  include Singleton

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  ROWING_MACHINE = 12
  INCHWORM = 14
  MED_BALL_LUNGE = 15
  PIRIFORMIS_STRETCH = 9
  HAMSTRING_STRETCH = 2
  QUAD_STRETCH = 10

  @entity
  @routine

  def add_exercises(entity, routine)
    @entity = entity
    @routine = routine

    @routine.add_warmup(ROWING_MACHINE, 3, 0)
    @routine.add_warmup(INCHWORM, 3, 0)
    @routine.add_warmup(MED_BALL_LUNGE, 3, 0)
    @routine.add_warmup(PIRIFORMIS_STRETCH, 3, 0)
    @routine.add_warmup(HAMSTRING_STRETCH, 3, 0)
    @routine.add_warmup(QUAD_STRETCH, 3, 0)

  end

  def copy_exercises(entity, routine, previous_routine)
    @entity = entity
    @routine = routine

    if previous_routine.changes_saved && previous_routine.wu_modified
      if entity.is_group?
        previous_exercises = previous_routine.group_performed_warmups
      else
        previous_exercises = previous_routine.performed_warm_ups
      end
      @routine.note_warmup_changes_saved
    else
      previous_exercises = previous_routine.get_warmups_without_changes_saved
    end

    previous_exercises.each do |exercise|
      status = exercise.status
      #If changes were not saved, make invisible default exercises visible.
      unless previous_routine.changes_saved
        if status == 2
          status = 3
        end
      end
      @routine.add_warmup(exercise.warmup_id, status, 0) #0 = group performed exercise id
    end

    if previous_routine.changes_saved && previous_routine.wu_modified
      #copy custom exercises
      previous_routine.get_custom_exercises(STRETCHING).each do |exercise|
        @routine.add_custom_exercise(exercise.name, STRETCHING, 0)
      end
    end

  end
end