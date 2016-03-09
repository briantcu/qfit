class RoutineService

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3
  MAX_EXERCISES = 15

  @date
  @entity #Either a user or group
  @routine
  @phase_number # 1-4
  @sched_update
  @cause_of_new_routine #Cron job to create new workouts, or schedule/goals change, or new member/group creation,
                        # or member removed from group. CRON, SCHED, NEW, REMOVED

  def initialize(entity, cause_of_new_routine, date, sched_update)
    @entity = entity
    @cause_of_new_routine = cause_of_new_routine
    @date = date
    @sched_update = sched_update
  end

  def self.nightly_workout_creation
    groups = Group.all
    groups.each do |group|
      RoutineService.new(group, 'CRON', nil, false).create_routines
    end
    sub_users = User.sub_users.without_group
    sub_users.each do |user|
      RoutineService.new(user, 'CRON', nil, false).create_routines
    end
    users = User.regular_users.logged_in_recently
    users.each do |user|
      RoutineService.new(user, 'CRON', nil, false).create_routines
    end
  end

  def self.sched_change_happened(entity)
    today = Date.today
    delete_old_workouts(entity)
    routine_service = RoutineService.new(entity, 'SCHED', today, true)
    routine_service.create_routines
  end

  def self.group_status_changed(user)
    delete_old_workouts(entity)
    if user.group.present?
      # sync with group workouts
      group.copy_workouts_to_user(user)
    else
      today = Date.today
      routine_service = RoutineService.new(user, 'REMOVED', today, true)
      routine_service.create_routines
    end
  end

  def self.get_open_workouts_start_today(entity)
    if entity.is_group?
      GroupRoutine.get_open_workouts_start_today(entity)
    else
      DailyRoutine.get_open_workouts_start_today(entity)
    end
  end

  def self.get_open_workouts(entity)
    if entity.is_group?
      GroupRoutine.get_open_workouts(entity)
    else
      DailyRoutine.get_open_workouts(entity)
    end
  end

  def self.has_open_workout_today?(entity)
    if entity.is_group?
      GroupRoutine.has_open_workout_today?(entity)
    else
      DailyRoutine.has_open_workout_today?(entity)
    end

  end

  def self.has_closed_workout?(entity, date)
    if entity.is_group?
      false
    else
      DailyRoutine.has_closed_workout?(entity, date)
    end
  end

  def self.has_exceeded_ex_count(routine, type)
    case type
      when STRETCHING
        (routine.performed_warm_ups.size + routine.custom_exercises.where(:ex_type => type).size) >= MAX_EXERCISES
      when WEIGHTS
        (routine.performed_exercises.size + routine.custom_exercises.where(:ex_type => type).size) >= MAX_EXERCISES
      when PLYOS
        (routine.performed_plyometrics.size + routine.custom_exercises.where(:ex_type => type).size) >= MAX_EXERCISES
      when SPRINTING
        (routine.performed_sprints.size + routine.custom_exercises.where(:ex_type => type).size) >= MAX_EXERCISES
    end
  end

  def set_date(date)
    @date = date
  end

  def create_routine
    return unless valid_entity_and_open_date?

    @routine = @entity.create_routine(@date)
    return unless @routine.present?

    @phase_number = @entity.get_schedule.maintain_phases(@date)

    weekly_schedule_day = @entity.get_schedule.get_schedule_day(@date)

    if weekly_schedule_day.stretching
      add_exercises(WarmupService, STRETCHING)
    end

    if weekly_schedule_day.weights
      weight_service = WeightsService.new(@entity, @routine, @phase_number, @sched_update, self)
      weight_service.add_weights
    end

    if weekly_schedule_day.plyometrics
      add_exercises(PlyometricsService, PLYOS)
    end

    if weekly_schedule_day.sprinting
      add_exercises(SprintingService, SPRINTING)
    end

    cleanup

    maybe_add_custom_exercises(weekly_schedule_day)

    @routine
  end

  def create_routines
    dates = create_date_array
    dates.each do |date|
      self.set_date(date)
      self.create_routine
    end
  end

  def get_next_day_id(type)
    next_day = 0
    case type
      when STRETCHING
        if @entity.is_group?
          next_day = @entity.last_wu_day_created
        else
          next_day = @entity.last_warmup_day_created
        end
      when WEIGHTS
        next_day = @entity.last_weight_day_created
      when PLYOS
        if @entity.is_group?
          next_day = @entity.last_pl_day_created
        else
          next_day = @entity.last_plyometric_day_created
        end
      when SPRINTING
        if @entity.is_group?
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
    #Only applies to 1 pillar
    temp_date = @date - 15
    if @entity.is_group?
      prev_routine  = GroupRoutine.get_matching_routine_since(temp_date, type, day_id, @entity.id)
    else
      prev_routine  = DailyRoutine.get_matching_routine_since(temp_date, type, day_id, @entity.id)
    end
    validate_routine_matches(prev_routine)
  end

  private

  def create_date_array
    dates = Array.new
    date = Date.today
    3.times do
      unless RoutineService.has_closed_workout?(@entity, date)
        dates.push(date)
      end
      date.advance(days: 1)
    end
    dates
  end

  def self.delete_old_workouts(entity)

    if RoutineService.has_open_workout_today?(entity)
      workouts = RoutineService.get_open_workouts_start_today(entity)
    else
      workouts = RoutineService.get_open_workouts(entity)
    end

    workouts.each do |workout|
      workout.destroy
    end

  end

  def get_matching_routines
    #gets all routines EXACTLY like the one we're creating...all pillars are the same
    if @entity.is_group?
      GroupRoutine.get_matching_routines(@routine)
    else
      DailyRoutine.get_matching_routines(@routine)
    end
  end

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

  def maybe_add_custom_exercises(weekly_schedule_day)
    previous_workouts = get_matching_routines
    if previous_workouts.size > 1
      previous_workout = previous_workouts[1]  #skip workout you just created
      if previous_workout.changes_saved
        complete_custom = false
        custom_exercise_service = CustomExerciseService.new(weekly_schedule_day, complete_custom, self, previous_workout)
        custom_exercise_service.add_custom_exercises
      end
    end
  end

  def valid_entity_and_open_date?
    #Check for the presence of entity and a schedule
    valid = (@entity != nil) && (@entity.get_schedule != nil) && (@date != nil)

    #check that if this is from cron, do not overwrite existing workout
    if @cause_of_new_routine == 'CRON'
      daily_routine = DailyRoutine.get_routine_by_date(@date.mon, @date.year, @date.mday, @entity.id)
      unless daily_routine.nil?
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
    @routine.save
  end

end