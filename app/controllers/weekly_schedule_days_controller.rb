class WeeklyScheduleDaysController < ApplicationController
  before_action :set_weekly_schedule_day, only: [:show, :edit, :update, :destroy]

  # GET /weekly_schedule_days
  # GET /weekly_schedule_days.json
  def index
    @weekly_schedule_days = WeeklyScheduleDay.all
  end

  # GET /weekly_schedule_days/1
  # GET /weekly_schedule_days/1.json
  def show
  end

  # GET /weekly_schedule_days/new
  def new
    @weekly_schedule_day = WeeklyScheduleDay.new
  end

  # GET /weekly_schedule_days/1/edit
  def edit
  end

  # POST /weekly_schedule_days
  # POST /weekly_schedule_days.json
  def create
    @weekly_schedule_day = WeeklyScheduleDay.new(weekly_schedule_day_params)

    respond_to do |format|
      if @weekly_schedule_day.save
        format.html { redirect_to @weekly_schedule_day, notice: 'Weekly schedule day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weekly_schedule_day }
      else
        format.html { render action: 'new' }
        format.json { render json: @weekly_schedule_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_schedule_days/1
  # PATCH/PUT /weekly_schedule_days/1.json
  def update
    respond_to do |format|
      if @weekly_schedule_day.update(weekly_schedule_day_params)
        format.html { redirect_to @weekly_schedule_day, notice: 'Weekly schedule day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weekly_schedule_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_schedule_days/1
  # DELETE /weekly_schedule_days/1.json
  def destroy
    @weekly_schedule_day.destroy
    respond_to do |format|
      format.html { redirect_to weekly_schedule_days_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_schedule_day
      @weekly_schedule_day = WeeklyScheduleDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_schedule_day_params
      params.require(:weekly_schedule_day).permit(:day, :user_schedule_id, :weights, :plyometrics, :stretching, :sprinting)
    end
end
