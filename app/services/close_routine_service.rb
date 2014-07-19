class CloseRoutineService

  @routine

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

  def close_routine
    note_as_closed
    update_user_weight
    process_user_maxes
    process_power_index
    process_completed_provided

    #@TODO
    #return encouraging message and next workout date

    #@TODO
    #post message to feed saying workout was completed
    # $message = "I just completed my workout: <a class='underlined' target='_blank' href='/share.html?r=rid'>
    # See it and make comments</a>"; PostToFeed($message, 3);

    @routine.save
    @routine.user.save
    @routine
  end

  private

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
        UserMax.set_max(@routine.user.id, perf_ex.exercise.id, max)
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

  def process_completed_provided
    completed_plyos = @routine.get_num_completed_plyos
    completed_warmups = @routine.get_num_completed_warmups
    completed_laps = @routine.get_num_completed_laps
    completed_sets = @routine.get_num_completed_weight_sets
    total_completed = completed_plyos + completed_warmups + completed_laps + completed_sets
    @routine.count_ex_completed = total_completed

    provided_plyos = @routine.get_num_provided_plyos
    provided_warmups = @routine.get_num_provided_warmups
    provided_laps = @routine.get_num_provided_laps
    provided_sets = @routine.get_num_provided_weight_sets
    total_provided = provided_plyos + provided_warmups + provided_laps + provided_sets
    @routine.count_ex_provided = total_provided

  end

end