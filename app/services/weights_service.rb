class WeightsService

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  @entity
  @routine
  @sched_update
  @phase_number
  @routine_service

  def initialize(entity, routine, phase_number, sched_update, routine_service)
    @entity = entity
    @routine = routine
    @sched_update = sched_update
    @phase_number = phase_number
    @routine_service = routine_service
  end

  def add_weights
    weight_day_index = get_weight_day_index
    program_day_id = ProgramDaySequence.get_program_day_id(weight_day_index, @entity.get_schedule.program_id)
    previous_routine = @routine_service.get_previous_matching_routine(WEIGHTS, program_day_id)
    if previous_routine.nil?
      add_exercises(program_day_id)
    else
      copy_exercises(previous_routine)
      copy_custom(previous_routine)
    end
    @routine.program_day_id = program_day_id
    @routine.wt_day_id = weight_day_index
    @routine.save!
    unless @sched_update
      @entity.last_weight_day_created = weight_day_index
      @entity.save!
    end
  end

  def copy_weights(previous_routine)
    copy_exercises(previous_routine)
  end

  private

  def add_exercises(program_day_id)
    exercise_types = DayExercise.get_exercises_for_day(program_day_id)
    exercise_types.each do |day_exercise|
      exercises = day_exercise.exercise_type.get_exercises(@entity.try(:experience_level), @entity.try(:paid_tier))
      total_count_for_index = exercises.count - 1
      while true
        index = rand(0..(total_count_for_index))
        exercise = exercises.at(index)
        if ExerciseValidatorService.instance.is_valid_exercise(@entity, @routine, exercise)
          @routine.add_weights(exercise, 3, 0)
          break
        end
      end
    end

  end

  def copy_exercises(previous_routine)

    if previous_routine.changes_saved && previous_routine.wt_modified
      previous_exercises = previous_routine.get_weights
      @routine.note_weight_changes_saved
    else
      previous_exercises = previous_routine.get_weights_without_changes_saved
    end

    previous_exercises.each do |exercise|
      status = exercise.status
      #If changes were not saved, make invisible default exercises visible.
      if !previous_routine.changes_saved
        if status == 2
          status = 3
        end
      end
      @routine.add_weights(exercise, status, 0) #0 = group performed exercise id
    end
  end

  def copy_custom(previous_routine)
    if previous_routine.changes_saved && previous_routine.wt_modified
      previous_routine.get_custom_exercises(WEIGHTS).each do |exercise|
        @routine.add_custom_exercise(exercise.name, WEIGHTS, 0)
      end
    end
  end

  def get_weight_day_index
    last_day = @entity.last_weight_day_created
    last_day ||= 0
    if @sched_update
      current_day_index = (last_day == 0) ? 1 : last_day
    else
      if last_day == 0
        current_day_index = 1
      else
        total_days = ProgramDaySequence.get_total_days(@entity.get_schedule.program_id)
        if last_day == total_days
          current_day_index = 1
        else
          current_day_index = last_day + 1
        end
      end
    end

    #to be safe
    total_days = ProgramDaySequence.get_total_days(@entity.get_schedule.program_id)
    if current_day_index > total_days
      current_day_index = 1
    end

    current_day_index
  end

end