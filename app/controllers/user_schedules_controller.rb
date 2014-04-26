class UserSchedulesController < ApplicationController
  before_action :set_user_schedule, only: [:show, :edit, :update, :destroy]

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

  # POST /user_schedules
  # POST /user_schedules.json
  def create
    @user_schedule = UserSchedule.new(user_schedule_params)

    respond_to do |format|
      if @user_schedule.save
        format.html { redirect_to @user_schedule, notice: 'User schedule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_schedule }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_schedules/1
  # PATCH/PUT /user_schedules/1.json
  def update
    respond_to do |format|
      if @user_schedule.update(user_schedule_params)
        format.html { redirect_to @user_schedule, notice: 'User schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_schedule.errors, status: :unprocessable_entity }
      end
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
      @user_schedule = UserSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_schedule_params
      params.require(:user_schedule).permit(:user_id, :program_id, :program_type, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start, :sign_up_date)
    end
end
