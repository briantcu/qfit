class PerformedSprintsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_performed_sprint, only: [:show, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  DELETED = 2

  # GET /performed_sprints/1.json
  def show
  end

  # PATCH/PUT /performed_sprints/1.json
  def update
    need_to_create_laps = (@performed_sprint.sprint_id != params[:performed_sprint][:sprint_id])
    if @performed_sprint.update_ex(performed_sprint_params, need_to_create_laps)
      render action: 'show', status: :ok, location: @performed_sprint
    else
      render json: @performed_sprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_sprints/1.json
  def destroy
    if @performed_sprint.status == 1 #Added exercise
      @performed_sprint.destroy
    else
      @performed_sprint.status = DELETED
      @performed_sprint.save
      @performed_sprint.daily_routine.note_sprints_changed
    end
    render json: {success: true}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_performed_sprint
    @performed_sprint = PerformedSprint.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def performed_sprint_params
    params.require(:performed_sprint).permit(:sprint_id)
  end

  def verify_owns_workout
    unauthorized unless (current_user.owns_workout?(@performed_sprint.routine_id))
  end
end
