class GroupPerformedExercisesController < ApplicationController
  before_action :set_group_performed_exercise, only: [:show, :update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # GET /group_performed_exercises/1
  # GET /group_performed_exercises/1.json
  def show
  end

  # PATCH/PUT /group_performed_exercises/1
  # PATCH/PUT /group_performed_exercises/1.json
  def update
    if @group_performed_exercise.exercise_id != params[:group_performed_exercise][:exercise_id]
      @group_performed_exercise.update_ex(group_performed_exercise_params)
      render action: 'show', status: :ok, location: @group_performed_exercise
    else
      render json: @group_performed_exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_exercises/1
  # DELETE /group_performed_exercises/1.json
  def destroy
    @group_performed_exercise.destroy_ex
    render json: {success: true}
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

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group(params[:group_performed_exercise][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
