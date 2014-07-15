class RoutineService

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  @date
  @entity #Either a user or group
  @routine
  @phase_number # 1-4
  @sched_update
  @cause_of_new_routine #Cron job to create new workouts, or schedule/goals change, or new member/group creation,
                        # or member removed from group. Cron, Sched, New, Removed

  def initialize(entity, cause_of_new_routine, date, sched_update)
    @entity = entity
    @cause_of_new_routine = cause_of_new_routine
    @date = date
    @sched_update = sched_update
  end

  def create_routine
    if valid_entity_and_open_date?
      @routine = @entity.create_routine(@date)
      if @routine.nil?
        return
      end

      @phase_number = @entity.get_schedule.maintain_phases(@date)

      weekly_schedule_day = @entity.get_schedule.get_schedule_day(@date)

      if weekly_schedule_day.stretching
        add_exercises(WarmupService, STRETCHING)
      end

      if weekly_schedule_day.weights
        add_exercises(WeightsService, WEIGHTS)
      end

      if weekly_schedule_day.plyometrics
        add_exercises(PlyometricsService, PLYOS)
      end

      if weekly_schedule_day.sprinting
        add_exercises(SprintingService, SPRINTING)
      end

      cleanup

      maybe_add_custom_exercises

      @routine
    end
  end

  def get_next_day_id(type)
    next_day = 0
    case type
      when STRETCHING
        if @entity.is_group
          next_day = @entity.last_wu_day_created
        else
          next_day = @entity.last_warmup_day_created
        end
      when WEIGHTS
        next_day = @entity.last_weight_day_created
      when PLYOS
        if @entity.is_group
          next_day = @entity.last_pl_day_created
        else
          next_day = @entity.last_plyometric_day_created
        end
      when SPRINTING
        if @entity.is_group
          next_day = @entity.last_sp_day_created
        else
          next_day = @entity.last_sprint_day_created
        end
    end

    if !@sched_update || (next_day == 0)
      total_days = @entity.get_schedule.get_total_days_of_pillar(type)
      next_day = next_day + 1
      if next_day > total_days
        next_day = 1
      end
    end
    next_day

  end

  def get_previous_matching_routine(type, day_id)
    temp_date = @date - 15
    if @entity.is_group
      prev_routine  = GroupRoutine.get_matching_routine_since(temp_date, type, day_id, @entity.id)
    else
      prev_routine  = DailyRoutine.get_matching_routine_since(temp_date, type, day_id, @entity.id)
    end
    validate_routine_matches(prev_routine)
  end

  private

  def add_exercises(service, type)
    day_id = self.get_next_day_id(type)
    previous_routine = self.get_previous_matching_routine(type, day_id)
    if previous_routine.nil?
      service.add_exercises(@entity, @routine)
    else
      service.copy_exercises(@entity, @routine, previous_routine)
    end
    @entity.note_last_day_created(day_id, type)
    @routine.note_day_created(day_id, type)
  end

  def validate_routine_matches(prev_routine)
    if prev_routine.nil?
      return nil
    end

    prev_phase = @entity.get_schedule.get_phase_by_date(prev_routine.day_performed)
    if prev_phase != @phase_number
      return nil
    end

    if prev_routine.id == @routine.id
      return nil
    end

    prev_routine
  end

  def maybe_add_custom_exercises

  end

  def valid_entity_and_open_date?
    #Check for the presence of entity and a schedule
    valid = (@entity != nil) && (@entity.get_schedule != nil) && (@date != nil)

    #check that if this is from cron, do not overwrite existing workout
    if @cause_of_new_routine == 'CRON'
      daily_routine = DailyRoutine.get_routine_by_date(@date.mon, @date.year, @date.mday, @entity.id)
      if !daily_routine.nil?
        if daily_routine.program_day_id != 0
          valid = false
        end
      end
    end

    #Make sure that they have a program id
    valid = valid && (@entity.get_schedule.program_id != nil)

    #Make sure that if we're dealing with an individual, they have a program type
    valid && ((@entity.instance_of? Group) || (@entity.get_schedule.program_type_id != nil))
  end

  def cleanup
    @entity.current_phase = @phase_number
    @entity.save

    #0 is a custom day, 99 is a Quadfit generated day with no weights
    if @routine.program_day_id == 0
      @routine.program_day_id = 99
    end
  end

end