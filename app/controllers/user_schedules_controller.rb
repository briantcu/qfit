class UserSchedulesController < ApplicationController
  before_action :set_user_schedule, only: [:show, :edit, :update, :destroy]
  before_filter :verify_is_logged_in_or_coach, only: [:create, :update]

  # GET /user_schedules
  # GET /user_schedules.json
  def index
    @user_schedules = UserSchedule.all
  end

  # GET /user_schedules/1
  # GET /user_schedules/1.json
  def show
  end

  # GET /user_schedules/new
  def new
    @user_schedule = UserSchedule.new
  end

  # GET /user_schedules/1/edit
  def edit
  end

  # POST /user_schedules.json
  def create
    existing_user_schedule = UserSchedule.where(:user_id => params[:user_schedule][:user_id].to_i).first

    if existing_user_schedule.nil?
      @user_schedule = UserSchedule.new(user_schedule_params)
      @user_schedule.setup_phases
      @user_schedule.sign_up_date = Date.current
      if @user_schedule.save
        render json: @user_schedule, status: :created, location: @user_schedule
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
      @user_schedule.save
      render json: @user_schedule, status: :ok, location: @user_schedule
    else
      render json: @user_schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_schedules/1
  # DELETE /user_schedules/1.json
  def destroy
    @user_schedule.destroy
    respond_to do |format|
      format.html { redirect_to user_schedules_url }
      format.json { head :no_content }
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
                                            :phase_three_start, :phase_four_start,
                                            weekly_schedule_days_attributes: [:id, :day, :weights, :plyometrics, :stretching, :sprinting])
    end

    def verify_is_logged_in_or_coach
      (current_user.nil?) ? unauthorized : unauthorized unless
          (current_user.id == params[:user_schedule][:user_id].to_i ||
              (current_user.is_coach_of_user(current_user, params[:user_schedule][:user_id].to_i)) ||
              (current_user.is_super_user))
    end

    def unauthorized
      render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
    end
end
