class WeightSetService

  @entity
  @routine
  @exercise
  @num_sets
  @num_reps
  @rest_period

  def initialize(entity, routine, exercise)
    @entity = entity
    @routine = routine
    @exercise = exercise
  end

  def create_sets
    program_type = @entity.get_schedule.program_type
    phase_number = @entity.get_schedule.get_phase_by_date(@routine.day_performed)
    phase_id = ProgramPhaseLookup.where(:phase_number => phase_number, :program_type => program_type).first.phase_id
    get_num_sets_and_reps(phase_id)
    set_rest_period
    calculate_recommended_loads
  end

  private

  def calculate_recommended_loads

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