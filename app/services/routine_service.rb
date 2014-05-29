class RoutineService

  @date
  @entity
  @routine
  @phase_number # 1-4
  @cause_of_new_routine #Cron job to create new workouts, or schedule/goals change, or new member/group creation,
                        # or member removed from group. Cron, Sched, New, Removed

  def initialize(entity, cause_of_new_routine, date)
    @entity = entity
    @cause_of_new_routine = cause_of_new_routine
    @date = date
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
        add_stretching
      end

      if weekly_schedule_day.weights
        add_weights
      end

      if weekly_schedule_day.plyometrics
        add_plyos
      end

      if weekly_schedule_day.sprinting
        add_sprinting
      end

      maybe_add_custom_exercises

      cleanup

      @routine
    end
  end

  private

  def add_stretching

  end

  def add_weights

  end

  def add_plyos

  end

  def add_sprinting

  end

  def maybe_add_custom_exercises

  end

  def valid_entity_and_open_date?
    #Check for the presence of entity and a schedule
    valid = (@entity != nil) && (@entity.get_schedule != nil)

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
    valid && ((@entity.get_schedule.program_type_id != nil) || (@entity.instance_of? Group))
  end

  def cleanup
    @entity.current_phase = @phase_number
    @entity.save

    if @routine.program_day_id == 0
      @routine.program_day_id = 99
    end
  end

end