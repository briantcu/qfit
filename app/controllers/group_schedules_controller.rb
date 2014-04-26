class GroupSchedulesController < ApplicationController
  before_action :set_group_schedule, only: [:show, :edit, :update, :destroy]

  # GET /group_schedules
  # GET /group_schedules.json
  def index
    @group_schedules = GroupSchedule.all
  end

  # GET /group_schedules/1
  # GET /group_schedules/1.json
  def show
  end

  # GET /group_schedules/new
  def new
    @group_schedule = GroupSchedule.new
  end

  # GET /group_schedules/1/edit
  def edit
  end

  # POST /group_schedules
  # POST /group_schedules.json
  def create
    @group_schedule = GroupSchedule.new(group_schedule_params)

    respond_to do |format|
      if @group_schedule.save
        format.html { redirect_to @group_schedule, notice: 'Group schedule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_schedule }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_schedules/1
  # PATCH/PUT /group_schedules/1.json
  def update
    respond_to do |format|
      if @group_schedule.update(group_schedule_params)
        format.html { redirect_to @group_schedule, notice: 'Group schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_schedules/1
  # DELETE /group_schedules/1.json
  def destroy
    @group_schedule.destroy
    respond_to do |format|
      format.html { redirect_to group_schedules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_schedule
      @group_schedule = GroupSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_schedule_params
      params.require(:group_schedule).permit(:group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start)
    end
end
