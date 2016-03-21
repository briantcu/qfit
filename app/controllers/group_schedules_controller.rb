class GroupSchedulesController < ApplicationController
  before_action :set_group_schedule, only: [:show, :update]
  before_filter :verify_is_logged_in_or_coach, only: [:create, :update]

  # GET /group_schedules/1
  # GET /group_schedules/1.json
  def show
  end

  # POST /group_schedules
  # POST /group_schedules.json
  def create
    existing_group_schedule = GroupSchedule.find_by_group_id(params[:group_schedule][:group_id].to_i)

    if existing_group_schedule.nil?
      @group_schedule = GroupSchedule.create_group_schedule(group_schedule_params)
      if @group_schedule.save
        @group_schedule.create_weekly_schedule_days
        update_group_record
        render action: 'show', status: :created, location: @group_schedule
      else
        render json: @group_schedule.errors, status: :unprocessable_entity
      end
    else
      @group_schedule = existing_group_schedule
      update
    end
  end

  # PATCH/PUT /group_schedules/1
  # PATCH/PUT /group_schedules/1.json
  def update
    if @group_schedule.update(group_schedule_params)
      @group_schedule.setup_phases
      @group_schedule.rollback_days_created
      @group_schedule.save!
      update_group_record
      RoutineService.sched_change_happened(@group_schedule.group)
      render action: 'show', status: :ok, location: @group_schedule
    else
      render json: @group_schedule.errors, status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_schedule
      @group_schedule = GroupSchedule.find(params[:id])
    end

    def update_group_record
      @group_schedule.group.update_program_info
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_schedule_params
      params.require(:group_schedule).permit(:group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start)
    end

    def verify_is_logged_in_or_coach
      group_id = params[:group_schedule][:group_id].to_i
      coach = Group.get_coach(group_id)
      (current_user.nil? || coach.nil?) ? unauthorized : unauthorized unless
          ((current_user.id == coach.id) || current_user.is_super_user)
    end

    def unauthorized
      render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
    end

end
