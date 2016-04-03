class PerformedWarmUpsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_performed_warm_up, only: [:show, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  DELETED = 2

  # GET /performed_warm_ups/1.json
  def show
  end

  # PATCH/PUT /performed_warm_ups/1.json
  def update
    if @performed_warm_up.update(performed_warm_up_params)
      render action: 'show', status: :ok, location: @performed_warm_up
    else
      render json: @performed_warm_up.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_warm_ups/1.json
  def destroy
    @performed_warm_up.status = DELETED
    @performed_warm_up.save
    @performed_warm_up.daily_routine.note_warmups_changed
    render json: {success: true}
  end

  private
  def set_performed_warm_up
    @performed_warm_up = PerformedWarmUp.find(params[:id])
  end

  def performed_warm_up_params
    params.require(:performed_warm_up).permit(:warmup_id)
  end

  def verify_owns_workout
    unauthorized unless (current_user.owns_workout?(@performed_warm_up.routine_id))
  end

end
