# == Schema Information
#
# Table name: performed_warm_ups
#
#  id              :integer          not null, primary key
#  routine_id      :integer
#  warmup_id       :integer
#  status          :integer
#  group_warmup_id :integer
#  completed       :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

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
      @daily_routine = @performed_warm_up.daily_routine
      render 'daily_routines/show'
    else
      render json: @performed_warm_up.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_warm_ups/1.json
  def destroy
    if @performed_warm_up.status == 1 #Added exercise
      @performed_warm_up.destroy
    else
      @performed_warm_up.status = DELETED
      @performed_warm_up.save
      @performed_warm_up.daily_routine.note_warmups_changed
    end
    @daily_routine = @performed_warm_up.daily_routine
    render 'daily_routines/show'
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
