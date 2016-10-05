require 'singleton'

class WarmupService
  include Singleton

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  ROWING_MACHINE = 12

  @entity
  @routine

  def add_exercises(entity, routine)
    @entity = entity
    @routine = routine

    # warmup
    @routine.add_warmup(ROWING_MACHINE, 3, 0)

    add_dynamic_stretches
    add_static_stretches
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

  private

  def add_dynamic_stretches
    add_stretches(2, 2)
  end

  def add_static_stretches
    add_stretches(3, 1)
  end

  def add_stretches(count, type)
    if @entity.is_group?
      warmups = Warmup.where(ex_type: type)
    else
      warmups = Warmup.where('paid_tier <= ?', @entity.paid_tier).where(ex_type: type)
    end
    num_warmups_for_index = warmups.count - 1

    (0..count - 1).each do |i|
      while true
        index = rand(0..(num_warmups_for_index))
        warmup = warmups.at(index)
        if ExerciseValidatorService.instance.is_valid_warmup(@entity, @routine, warmup)
          @routine.add_warmup(warmup.id, 3, 0)
          break
        end
      end
    end
  end
end