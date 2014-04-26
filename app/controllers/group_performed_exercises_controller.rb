class GroupPerformedExercisesController < ApplicationController
  before_action :set_group_performed_exercise, only: [:show, :edit, :update, :destroy]

  # GET /group_performed_exercises
  # GET /group_performed_exercises.json
  def index
    @group_performed_exercises = GroupPerformedExercise.all
  end

  # GET /group_performed_exercises/1
  # GET /group_performed_exercises/1.json
  def show
  end

  # GET /group_performed_exercises/new
  def new
    @group_performed_exercise = GroupPerformedExercise.new
  end

  # GET /group_performed_exercises/1/edit
  def edit
  end

  # POST /group_performed_exercises
  # POST /group_performed_exercises.json
  def create
    @group_performed_exercise = GroupPerformedExercise.new(group_performed_exercise_params)

    respond_to do |format|
      if @group_performed_exercise.save
        format.html { redirect_to @group_performed_exercise, notice: 'Group performed exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_performed_exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_performed_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_performed_exercises/1
  # PATCH/PUT /group_performed_exercises/1.json
  def update
    respond_to do |format|
      if @group_performed_exercise.update(group_performed_exercise_params)
        format.html { redirect_to @group_performed_exercise, notice: 'Group performed exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_performed_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_performed_exercises/1
  # DELETE /group_performed_exercises/1.json
  def destroy
    @group_performed_exercise.destroy
    respond_to do |format|
      format.html { redirect_to group_performed_exercises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_exercise
      @group_performed_exercise = GroupPerformedExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_exercise_params
      params.require(:group_performed_exercise).permit(:performed_exercise_id, :routine_id, :exercise_id, :status, :exercise_type)
    end
end
