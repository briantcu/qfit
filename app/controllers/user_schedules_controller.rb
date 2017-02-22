# == Schema Information
#
# Table name: user_schedules
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  program_id        :integer
#  program_type_id   :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  sign_up_date      :date
#  created_at        :datetime
#  updated_at        :datetime
#

class UserSchedulesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_user_schedule, only: [:show, :update]
  before_action :verify_can_access_schedule, only: [:show]
  before_filter :verify_is_logged_in_or_coach, only: [:create, :update]

  # GET /user_schedules/1.json
  def show
  end

  # POST /user_schedules.json
  def create
    existing_user_schedule = UserSchedule.find_by_user_id(params[:user_schedule][:user_id].to_i)

    if existing_user_schedule.nil?
      if @user_schedule = UserSchedule.create_user_schedule(user_schedule_params)
        update_user_record
        RoutineService.new(@user_schedule.user, 'NEW', Time.zone.today).create_routines
        next_routine = DailyRoutine.get_open_workouts_start_today(@user_schedule.user).first
        session_service = SessionService.new(session)
        session_service.set_onboarding(false) # onboarding is done
        render action: 'show', status: :created, location: "/workout/#{next_routine.try(:id)}"
      else
        render json: @user_schedule.errors, status: :unprocessable_entity
      end
    else
      @user_schedule = existing_user_schedule
      update
    end

  end

  # PATCH/PUT /user_schedules/1.json
  def update
    if @user_schedule.update_self!(user_schedule_params)
      update_user_record
      RoutineService.sched_change_happened(@user_schedule.user)
      next_routine = DailyRoutine.get_open_workouts_start_today(@user_schedule.user).first
      render action: 'show', status: :ok, location: "/workout/#{next_routine.try(:id)}"
    else
      render json: @user_schedule.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user_schedule
    @user_schedule = UserSchedule.includes(:weekly_schedule_days).find(params[:id])
  end

  def user_schedule_params
    params.require(:user_schedule).permit(:program_id, :program_type_id, :phase_one_start, :phase_two_start,
                                          :phase_three_start, :phase_four_start, :user_id,
                                          weekly_schedule_days_attributes: [:id, :day, :weights, :plyometrics,
                                                                            :stretching, :sprinting])
  end

  def update_user_record
    @user_schedule.user.update_program_info
  end

  def verify_is_logged_in_or_coach
    unauthorized unless
        (current_user.id == params[:user_schedule][:user_id].to_i ||
            (current_user.is_coach_of_user?(params[:user_schedule][:user_id].to_i)) ||
            (current_user.is_super_user?))
  end

  def verify_can_access_schedule
    unauthorized unless
        (current_user.id == @user_schedule.user_id) || current_user.is_coach_of_user?(@user_schedule.user_id)
  end

end
