# == Schema Information
#
# Table name: performed_plyometrics
#
#  id                            :integer          not null, primary key
#  plyometric_id                 :integer
#  routine_id                    :integer
#  status                        :integer
#  group_performed_plyometric_id :integer
#  performed_one                 :boolean
#  performed_two                 :boolean
#  performed_three               :boolean
#  created_at                    :datetime
#  updated_at                    :datetime
#

class PerformedPlyometricsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_performed_plyometric, only: [:show, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  DELETED = 2

  # GET /performed_plyometrics/1.json
  def show
  end

  # PATCH/PUT /performed_plyometrics/1.json
  def update
    exercise = Plyometric.find(params[:performed_plyometric][:plyometric_id])
    if exercise.paid_tier > current_user.exercise_tier
      render json: { success: false, errors: "You don't have access to that exercise. Please upgrade your subscription." }, :status => 401
      return
    end
    if @performed_plyometric.update(performed_plyometric_params)
      @daily_routine = @performed_plyometric.daily_routine
      render 'daily_routines/show'
    else
      render json: @performed_plyometric.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_plyometrics/1.json
  def destroy
    if @performed_plyometric.status == 1 #Added exercise
      @performed_plyometric.destroy
    else
      @performed_plyometric.status = DELETED
      @performed_plyometric.save
      @performed_plyometric.daily_routine.note_plyos_changed
    end

    @daily_routine = @performed_plyometric.daily_routine
    render 'daily_routines/show'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_performed_plyometric
    @performed_plyometric = PerformedPlyometric.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def performed_plyometric_params
    params.require(:performed_plyometric).permit(:plyometric_id)
  end

  def verify_owns_workout
    unauthorized unless (current_user.owns_workout?(@performed_plyometric.routine_id))
  end
end
