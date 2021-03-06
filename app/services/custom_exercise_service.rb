class CustomExerciseService

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  @weekly_schedule_day
  @routine_service
  @is_complete_custom
  @routine
  @previous_workout

  def initialize(weekly_schedule_day, is_complete_custom, routine_service, previous_workout)
    @routine_service = routine_service
    @weekly_schedule_day = weekly_schedule_day
    @is_complete_custom = is_complete_custom
    @previous_workout = previous_workout
  end

  def add_custom_exercises
    if @is_complete_custom
      @routine = @routine_service.create_custom_routine
      copy_warmups
      copy_weights
      copy_plyos
      copy_sprints
    else
      #this is called at the tail end of creating a regular workout day
      # If you had a Quad for that day, custom exercises were already copied over. This is only if you didn't have
      # a Quad scheduled, but you added exercises anyway.
      @routine = @routine_service.routine
      if @previous_workout.changes_saved
        unless @weekly_schedule_day.stretching
          copy_warmups
        end

        unless @weekly_schedule_day.weights
          copy_weights
        end

        unless @weekly_schedule_day.plyometrics
          copy_plyos
        end

        unless @weekly_schedule_day.sprinting
          copy_sprints
        end
      end
    end
    @routine
  end

  def copy_sprints
    if @is_complete_custom
      old_sprints = @previous_workout.get_sprints
      if old_sprints.count > 0
        @routine.note_sprint_changes_saved
        old_sprints.each do |sprint|
          @routine.add_sprint(sprint.id, 1, 0)
        end
      end
    end

    @previous_workout.get_custom_exercises(SPRINTING).each do |exercise|
      @routine.add_custom_exercise(exercise.name, SPRINTING, 0)
    end
  end

  def copy_warmups
    if @is_complete_custom
      old_warmups = @previous_workout.get_warmups
      if old_warmups.count > 0
        @routine.note_warmup_changes_saved
        old_warmups.each do |warmup|
          @routine.add_warmup(warmup.id, 1, 0)
        end
      end
    end

    @previous_workout.get_custom_exercises(STRETCHING).each do |exercise|
      @routine.add_custom_exercise(exercise.name, STRETCHING, 0)
    end
  end

  def copy_plyos
    if @is_complete_custom
      old_plyos = @previous_workout.get_plyos
      if old_plyos.count > 0
        @routine.note_plyometric_changes_saved
        old_plyos.each do |plyo|
          @routine.add_plyometric(plyo.id, 1, 0)
        end
      end
    end

    @previous_workout.get_custom_exercises(PLYOS).each do |exercise|
      @routine.add_custom_exercise(exercise.name, PLYOS, 0)
    end
  end

  def copy_weights
    if @is_complete_custom
      old_weights = @previous_workout.get_weights
      if old_weights.count > 0
        weight_service = WeightsService.new(@routine_service.entity, @routine,
                                            @routine_service.phase_number,
                                            @routine_service)
        weight_service.copy_weights(@previous_workout)
      end
    end

    @previous_workout.get_custom_exercises(WEIGHTS).each do |exercise|
      @routine.add_custom_exercise(exercise.name, WEIGHTS, 0)
    end
  end

end