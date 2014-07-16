class WeightSetService

  @entity
  @routine
  @exercise
  @num_sets
  @num_reps
  @rest_period
  @sets
  @user_max
  @rec_max_array
  @rough_loads_array
  @refined_loads_array

  #@TODO should be based on user experience
  STANDARD_ATROPHY = 0.95

  def initialize(entity, routine, exercise)
    @entity = entity
    @routine = routine
    @exercise = exercise
    @rec_max_array = Array.new
    @rough_loads_array = Array.new
    @refined_loads_array = Array.new
    @sets = Array.new
  end

  def create_sets
    program_type = @entity.get_schedule.program_type
    phase_number = @entity.get_schedule.get_phase_by_date(@routine.day_performed)
    phase_id = ProgramPhaseLookup.get_phase_id(phase_number, program_type)
    get_num_sets_and_reps(phase_id)
    set_rest_period
    calculate_recommended_loads
    @sets
  end

  private

  def calculate_recommended_loads
    if (@exercise.exercise.category == 3) || (@exercise.exercise.category == 4)
      create_sets_for_exception
      return
    end

    if @exercise.exercise.category == 6
      create_sets_for_med_ball
      return
    end

    @user_max = calculate_user_max * 1.03
    @rec_max_array = create_rec_max_array(STANDARD_ATROPHY)
    normalize_loads_for_reps
    validate_loads
    create_weight_sets
  end

  def create_weight_sets
    for i in 1..(@num_sets) do
      @sets.push(WeightSet.create(set_num: i, performed_exercise_id: @exercise.id, rec_weight: @refined_loads_array[i-1], rec_reps: @num_reps))
    end
  end

  def normalize_loads_for_reps
    #@TODO will change for variable reps within set
    for i in 1..(@num_sets) do
      @rough_loads_array.push(OneRepMax.get_weight(@num_reps, @rec_max_array.at(i-1)))
    end

    if @exercise.exercise.is_body_weight
      calculate_body_weight_loads
    end
  end

  def calculate_body_weight_loads
    case @exercise.exercise.id
      when 54 #assisted pullup
        get_assisted_bw_load
      when 58 # assisted dips
        get_assisted_bw_load
      when 59 #dips with weight belt
        get_belt_bw_load
      when 131 #assisted chinup
        get_assisted_bw_load
      when 132 #assisted wide grip pullup
        get_assisted_bw_load
      when 133 #pullups with weight belt
        get_belt_bw_load
      when 134 #chinups with weight belt
        get_belt_bw_load
      when 135 #wide grip pullups with weight belt
        get_belt_bw_load
    end
  end

  def validate_loads
    for i in 1..(@num_sets) do
      @refined_loads_array[i - 1] = @rough_loads_array[i - 1].to_i
    end

    case @exercise.exercise.category
      when 1 #barbell
        for i in 1..(@num_sets) do
          mod = 5
          refine_loads(mod, i - 1)
        end
      when 2 #dumbbell
        for i in 1..(@num_sets) do
          mod = (@refined_loads_array[i - 1] < 40) ? 2.5 : 5
          refine_loads(mod, i - 1)
        end
      when 7 #cable
        for i in 1..(@num_sets) do
          mod = (@refined_loads_array[i - 1] < 60) ? 10 : 15
          refine_loads(mod, i - 1)
        end
      when 8 #plate
        for i in 1..(@num_sets) do
          mod = 2.5
          refine_loads(mod, i - 1)
        end
      when 9 #single plate
        for i in 1..(@num_sets) do
          index = i - 1
          if @refined_loads_array[index] > 45
            @refined_loads_array[index] = 45
          elsif @refined_loads_array[index] > 35
            @refined_loads_array[index] = 35
          elsif @refined_loads_array[index] > 25
            @refined_loads_array[index] = 25
          elsif @refined_loads_array[index] > 10
            @refined_loads_array[index] = 10
          elsif @refined_loads_array[index] > 45
            @refined_loads_array[index] = 5
          elsif @refined_loads_array[index] > 2.5
            @refined_loads_array[index] = 2.5
          else
            @refined_loads_array[index] = 0
          end
        end
    end
  end

  def refine_loads(mod, i)
    remainder = @refined_loads_array[i] % mod
    @refined_loads_array[i] = @refined_loads_array[i] - remainder
    if remainder >= mod/2
      @refined_loads_array[i] = @refined_loads_array[i] + mod
    end
  end

  def get_assisted_bw_load
    for i in 1..(@num_sets) do
      weight = @entity.weight - @rough_loads_array[i-1]
      @rough_loads_array[i-1] = check_body_weight(weight)
    end
  end

  def get_belt_bw_load
    for i in 1..(@num_sets) do
      weight = @rough_loads_array[i-1] - @entity.weight
      @rough_loads_array[i-1] = check_body_weight(weight)
    end
  end

  def check_body_weight(weight)
    (weight > 0) ? weight : 0
  end

  def create_rec_max_array(atrophy)
    @rec_max_array.push(@user_max)
    for i in 1..(@num_sets-1) do
      @rec_max_array.push(@rec_max_array.at(i-1) * atrophy)
    end

    @rec_max_array.reverse
  end

  def calculate_user_max
    user_max = UserMax.get_max(@entity.id, @exercise.exercise.id)
    if (!user_max.nil?) && (user_max.max != 0)
      if (@routine.day_performed.to_datetime - user_max.created_at.to_datetime) > 21.days
        return max
      end
    end

    get_max_from_lookup
  end

  def get_max_from_lookup
    case @exercise.exercise.look_up_value
      when 1
        max = @entity.knee_dom_max
      when 2
        max = @entity.hor_push_max
      when 3
        max = @entity.hor_pull_max
    end

    user_max = max * @exercise.exercise.percent_of_luv
    user_max.to_i
  end

  def create_sets_for_med_ball
    val = 4
    hpm = @entity.hor_push_max

    if hpm > 100
      val = 6
    end

    if hpm > 160
      val = 8
    end

    if hpm > 210
      val = 10
    end

    for i in 1..(@num_sets) do
      @sets.push(WeightSet.create(set_num: i, performed_exercise_id: @exercise.id, rec_weight: val, rec_reps: @num_reps))
    end
  end

  def create_sets_for_exception
    for i in 1..(@num_sets) do
      @sets.push(WeightSet.create(set_num: i, performed_exercise_id: @exercise.id, rec_weight: 0, rec_reps: @num_reps))
    end
  end

  def set_rest_period
    if (@exercise.exercise_type.id == 1) || (@num_reps < 5)
      @rest_period = 90
    else
      @rest_period = 60
    end

    @exercise.rest_period = @rest_period
    @exercise.save
  end

  def get_num_sets_and_reps(phase_id)
    phase = Phase.find(phase_id)
    if @exercise.exercise_type.id == 1
      if @entity.sex == 'male'
        set_num_sets_and_reps(phase.male_power_sets, phase.male_power_reps)
      else
        set_num_sets_and_reps(phase.fem_power_sets, phase.fem_power_reps)
      end
    else
      if @entity.sex == 'male'
        set_num_sets_and_reps(phase.male_other_sets, phase.male_other_reps)
      else
        set_num_sets_and_reps(phase.fem_other_sets, phase.fem_other_reps)
      end
    end

    #This makes leg exercises in the Super Quad program 3 sets
    if ((@entity.get_schedule.program.id == 5) && (exercise_should_be_three_sets(@exercise.exercise_type.id)))
      @num_sets = 3
    end

  end

  def exercise_should_be_three_sets(exercise_type)
    ((exercise_type == 2) || (exercise_type == 3) || (exercise_type == 4) || (exercise_type == 5))
  end

  def set_num_sets_and_reps(sets, reps)
    @num_reps = reps
    @num_sets = sets
  end


end