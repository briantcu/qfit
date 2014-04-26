class GroupScheduleDaysController < ApplicationController
  before_action :set_group_schedule_day, only: [:show, :edit, :update, :destroy]

  # GET /group_schedule_days
  # GET /group_schedule_days.json
  def index
    @group_schedule_days = GroupScheduleDay.all
  end

  # GET /group_schedule_days/1
  # GET /group_schedule_days/1.json
  def show
  end

  # GET /group_schedule_days/new
  def new
    @group_schedule_day = GroupScheduleDay.new
  end

  # GET /group_schedule_days/1/edit
  def edit
  end

  # POST /group_schedule_days
  # POST /group_schedule_days.json
  def create
    @group_schedule_day = GroupScheduleDay.new(group_schedule_day_params)

    respond_to do |format|
      if @group_schedule_day.save
        format.html { redirect_to @group_schedule_day, notice: 'Group schedule day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_schedule_day }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_schedule_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_schedule_days/1
  # PATCH/PUT /group_schedule_days/1.json
  def update
    respond_to do |format|
      if @group_schedule_day.update(group_schedule_day_params)
        format.html { redirect_to @group_schedule_day, notice: 'Group schedule day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_schedule_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_schedule_days/1
  # DELETE /group_schedule_days/1.json
  def destroy
    @group_schedule_day.destroy
    respond_to do |format|
      format.html { redirect_to group_schedule_days_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_schedule_day
      @group_schedule_day = GroupScheduleDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_schedule_day_params
      params.require(:group_schedule_day).permit(:group_schedule_id, :weights, :plyos, :stretching, :sprinting)
    end
end
