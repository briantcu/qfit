class GroupCustomExercisesController < ApplicationController
  before_action :set_group_custom_exercise, only: [:show, :destroy]
  before_filter :verify_owns_group, only: [:destroy]

  # GET /group_custom_exercises/1
  # GET /group_custom_exercises/1.json
  def show
  end

  # DELETE /group_custom_exercises/1
  # DELETE /group_custom_exercises/1.json
  def destroy
    @group_custom_exercise.destroy_ex
    render json: {success: true}
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

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group(params[:id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
