class GroupCustomExercisesController < ApplicationController
  before_action :set_group_custom_exercise, only: [:show, :edit, :update, :destroy]

  # GET /group_custom_exercises
  # GET /group_custom_exercises.json
  def index
    @group_custom_exercises = GroupCustomExercise.all
  end

  # GET /group_custom_exercises/1
  # GET /group_custom_exercises/1.json
  def show
  end

  # GET /group_custom_exercises/new
  def new
    @group_custom_exercise = GroupCustomExercise.new
  end

  # GET /group_custom_exercises/1/edit
  def edit
  end

  # POST /group_custom_exercises
  # POST /group_custom_exercises.json
  def create
    @group_custom_exercise = GroupCustomExercise.new(group_custom_exercise_params)

    respond_to do |format|
      if @group_custom_exercise.save
        format.html { redirect_to @group_custom_exercise, notice: 'Group custom exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_custom_exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_custom_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_custom_exercises/1
  # PATCH/PUT /group_custom_exercises/1.json
  def update
    respond_to do |format|
      if @group_custom_exercise.update(group_custom_exercise_params)
        format.html { redirect_to @group_custom_exercise, notice: 'Group custom exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_custom_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_custom_exercises/1
  # DELETE /group_custom_exercises/1.json
  def destroy
    @group_custom_exercise.destroy
    respond_to do |format|
      format.html { redirect_to group_custom_exercises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_custom_exercise
      @group_custom_exercise = GroupCustomExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_custom_exercise_params
      params.require(:group_custom_exercise).permit(:routine_id, :details, :status, :name, :type)
    end
end
