class UserSchedulesController < ApplicationController
  before_action :set_user_schedule, only: [:show, :edit, :update]
  before_filter :verify_is_logged_in_or_coach, only: [:create, :update]
  # GET /user_schedules/1
  # GET /user_schedules/1.json
  def show
  end

  # GET /user_schedules/1/edit
  def edit
  end

  # POST /user_schedules.json
  def create
    existing_user_schedule = UserSchedule.find_by_user_id(params[:user_schedule][:user_id].to_i)

    if existing_user_schedule.nil?
      @user_schedule = UserSchedule.create_user_schedule(user_schedule_params)
      if @user_schedule.save
        @user_schedule.create_weekly_schedule_days
        update_user_record
        render action: 'show', status: :created, location: @user_schedule
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
    if @user_schedule.update(user_schedule_params)
      @user_schedule.setup_phases
      @user_schedule.rollback_days_created
      @user_schedule.save
      update_user_record
      RoutineService.sched_change_happened(@user_schedule.user)
      render action: 'show', status: :ok, location: @user_schedule
    else
      render json: @user_schedule.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_schedule
      @user_schedule = UserSchedule.includes(:weekly_schedule_days).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
      (current_user.nil?) ? unauthorized : unauthorized unless
          (current_user.id == params[:user_schedule][:user_id].to_i ||
              (current_user.is_coach_of_user(params[:user_schedule][:user_id].to_i)) ||
              (current_user.is_super_user))
    end

    def unauthorized
      render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
    end
end
