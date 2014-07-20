class PerformedExercisesController < ApplicationController
  before_action :set_performed_exercise, only: [:show, :edit, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update]

  # GET /performed_exercises
  # GET /performed_exercises.json
  def index
    @performed_exercises = PerformedExercise.all
  end

  # GET /performed_exercises/1
  # GET /performed_exercises/1.json
  def show
  end

  # GET /performed_exercises/new
  def new
    @performed_exercise = PerformedExercise.new
  end

  # GET /performed_exercises/1/edit
  def edit
  end

  # POST /performed_exercises
  # POST /performed_exercises.json
  def create
    @performed_exercise = PerformedExercise.new(performed_exercise_params)

    respond_to do |format|
      if @performed_exercise.save
        format.html { redirect_to @performed_exercise, notice: 'Performed exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @performed_exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @performed_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performed_exercises/1
  def update
    need_to_create_sets = (@performed_exercise.exercise_id != params[:performed_exercise][:exercise_id])
    if @performed_exercise.update(performed_exercise_params)
      if need_to_create_sets
        weight_set_service = WeightSetService.new(@performed_exercise.daily_routine.user,
                                                  @performed_exercise.daily_routine, @performed_exercise)
        weight_set_service.create_sets
      end
      render action: 'show', status: :ok, location: @performed_exercise
    else
      render json: @performed_exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_exercises/1
  # DELETE /performed_exercises/1.json
  def destroy
    @performed_exercise.destroy
    respond_to do |format|
      format.html { redirect_to performed_exercises_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_performed_exercise
    @performed_exercise = PerformedExercise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def performed_exercise_params
    params.require(:performed_exercise).permit(:routine_id, :exercise_id, :rest_period, :status, :one_rep_max,
                                               :group_performed_exercise_id, :exercise_type)
  end

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout(params[:performed_exercise][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
