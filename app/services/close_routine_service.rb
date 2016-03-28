class CloseRoutineService

  BARBELL = 1
  DUMBBELL = 2
  MAX_REPS = 3
  TIME = 4
  MED_BALL = 6
  CABLE = 7
  PLATE = 8
  SINGLE_PLATE = 9

  BENCH_MAX = 1000
  SQUAT_MAX = 1200
  PULL_MAX = 600


  def initialize(routine)
    @routine = routine
  end

  def set_routine(routine)
    @routine = routine
  end

  def close_routine
    note_as_closed
    update_user_weight
    process_user_maxes
    process_power_index
    process_completed
    process_provided

    #post message to feed saying workout was completed
    #@TODO fix message
    message = "I just completed my workout: <a class='underlined' target='_blank' href='/share.html?r=rid'> See it and make comments</a>"
    Message.create!(poster_id: @routine.user.id, type: 3, message: message)

    # Get points based on the percentage of exercises completed
    points = process_completed / process_provided * 100
    @routine.user.points += points

    on_a_run = is_on_a_run?
    is_first_workout = is_first_workout?
    @routine.save!
    @routine.user.save!
    get_messages(true, on_a_run, is_first_workout)
    @routine
  end

  def skip_routine
    note_as_closed
    @routine.count_ex_completed = 0
    process_provided
    @routine.save!

    get_messages(false, false, false)
    @routine
  end

  private

  def get_messages(is_completed, is_on_run, is_first_workout)
    unless is_completed
      @routine.routine_messages.create!(message: "That's ok, everyone skips a workout every once in a while. Let's get it done next time!")
    end

    personal_bests = @pbs.take(3)
    personal_bests.each do |pb|
      Message.create!(poster_id: @routine.user.id, type: 3, message: "New personal best! #{pb[0].name}, #{pb[1]} estimated 1 rep max!")

    end
    @routine.routine_messages.create!(message: "Nice! You recorded personal bests for #{@pbs.map{|pb| pb[0].name}.join(', ')}")

    @routine.routine_messages.create!(message: "CONGRATULATIONS!!! You finished your first Quadfit workout! Keep it going!!") if is_first_workout

    @routine.routine_messages.create!(message: "You've completed 4+ workouts in a row! Keep up the momentum!!") if is_on_run

    next_open_workout = DailyRoutine.get_open_workouts_start_today(@routine.user).first
    if next_open_workout.present?
      #@TODO fix message
      @routine.routine_messages.create!(message: "Your next workout is #{next_open_workout.day_performed}")
    end

  end

  def is_first_workout?
    #record a goal and assign points if this is their first closed workout.
    first_workout = false
    if @routine.user.daily_routines.completed.count == 0
      goal = GoalDefinition.find(4)
      @routine.user.points += goal.points
      UserGoal.create!(user_id: @routine.user.id, goal_definition_id: 4)
      first_workout = true
    end
    first_workout
  end

  def is_on_a_run?
    on_a_run = false
    routines = @routine.user.daily_routines.offset(1).last(3)
    if routines.count == 3
      routines.each do |routine|
        on_a_run = on_a_run && routine.completed?
      end
    end
    if on_a_run
      @routine.user.points += 15
    end
    on_a_run
  end

  def note_as_closed
    @routine.closed = true
  end

  def update_user_weight
    @routine.user.weight = @routine.weight
  end

  def process_user_maxes
    @routine.performed_exercises.each do |perf_ex|
      assisted_check = (perf_ex.exercise.category == CABLE) && (perf_ex.exercise.is_body_weight)
      if (perf_ex.exercise.category != TIME) && (perf_ex.exercise.category != MAX_REPS) && (!assisted_check)
        max = 0
        perf_ex.weight_sets.each do |weight_set|
          if (weight_set.perf_reps != 0) && (weight_set.perf_weight != 0) # If work was done
            temp_max = OneRepMax.get_max(weight_set.perf_reps, weight_set.perf_weight)
            max = (temp_max > max) ? temp_max : max # Store the highest max from the set
          end
        end
        if max != 0
          perf_ex.one_rep_max = max
          perf_ex.save
        end
        is_pb = UserMax.set_max(@routine.user.id, perf_ex.exercise.id, max)
        @pbs << [perf_ex.exercise, max] if is_pb
        update_maxes_in_user_rec(max, perf_ex.exercise)
      end

    end
  end

  def update_maxes_in_user_rec(max, exercise)
    case exercise.look_up_value
      when 1
        stored_max = @routine.user.knee_dom_max
      when 2
        stored_max = @routine.user.hor_push_max
      when 3
        stored_max = @routine.user.hor_pull_max
    end

    # 75% weighting to stored value
    max_val = (stored_max * 3) + (max / exercise.percent_of_luv)
    max_val = max_val / 4

    case exercise.look_up_value
      when 1
        @routine.user.knee_dom_max = max_val.to_i
      when 2
        @routine.user.hor_push_max = max_val.to_i
      when 3
        @routine.user.hor_pull_max = max_val.to_i
    end

  end

  def process_power_index
    user_squat = @routine.user.knee_dom_max
    user_bench = @routine.user.hor_push_max
    user_pull = @routine.user.hor_pull_max

    us = user_squat / SQUAT_MAX
    ub = user_bench / BENCH_MAX
    up = user_pull / PULL_MAX

    total = us + ub + up # Sum of the percentages of max possible values
    pi = total * 100 / 3 # Make percentage a number from 1-100
    pi = pi * 2 # On a scale of 1-200
    power_index = pi.to_i
    @routine.user.power_index = power_index
    @routine.power_index = power_index
  end

  def process_completed
    completed_plyos = @routine.get_num_completed_plyos
    completed_warmups = @routine.get_num_completed_warmups
    completed_laps = @routine.get_num_completed_laps
    completed_sets = @routine.get_num_completed_weight_sets
    total_completed = completed_plyos + completed_warmups + completed_laps + completed_sets
    @routine.count_ex_completed = total_completed
  end

  def process_provided
    provided_plyos = @routine.get_num_provided_plyos
    provided_warmups = @routine.get_num_provided_warmups
    provided_laps = @routine.get_num_provided_laps
    provided_sets = @routine.get_num_provided_weight_sets
    total_provided = provided_plyos + provided_warmups + provided_laps + provided_sets
    @routine.count_ex_provided = total_provided
  end

end