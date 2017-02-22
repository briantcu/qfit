# == Schema Information
#
# Table name: group_schedules
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  program_id        :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  created_at        :datetime
#  updated_at        :datetime
#

class GroupSchedulesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_schedule, only: [:show, :update]
  before_filter :verify_is_coach, only: [:create, :update]
  before_filter :verify_owns_group, only: [:update]

  # GET /group_schedules/1.json
  def show
  end

  # POST /group_schedules.json
  def create
    existing_group_schedule = GroupSchedule.find_by_group_id(params[:group_schedule][:group_id].to_i)

    if existing_group_schedule.nil?
      @group_schedule = GroupSchedule.create_group_schedule(group_schedule_params)
      if @group_schedule.save
        update_group_record
        RoutineService.new(@group_schedule.group, 'NEW', Time.zone.today).create_routines
        next_routine = GroupRoutine.get_open_workouts_start_today(@group_schedule.group).first
        session_service = SessionService.new(session)
        session_service.set_onboarding(false) # onboarding is done
        render action: :show, status: :created, location: "/workout/#{next_routine.try(:id)}"
      else
        render json: @group_schedule.errors, status: :unprocessable_entity
      end
    else
      @group_schedule = existing_group_schedule
      update
    end
  end

  # PATCH/PUT /group_schedules/1.json
  def update
    if @group_schedule.update_self!(group_schedule_params)
      @group_schedule.setup_phases
      @group_schedule.rollback_days_created
      @group_schedule.save!
      update_group_record
      @group_schedule.group.members.each { |member| @group_schedule.group.copy_schedule_to_user(member)}
      RoutineService.sched_change_happened(@group_schedule.group)
      next_routine = GroupRoutine.get_open_workouts_start_today(@group_schedule.group).first
      render action: :show, status: :ok, location: "/workout/#{next_routine.try(:id)}"
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

  def group_schedule_params
    params.require(:group_schedule).permit(:group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start,
                                            group_schedule_days_attributes: [:id, :day, :weights, :plyometrics, :stretching, :sprinting])
  end

  def verify_is_coach
    unauthorized unless current_user.is_coach?
  end

  def verify_owns_group
    group_id = params[:group_schedule][:group_id].to_i
    coach = Group.get_coach(group_id)
    return unauthorized if coach.nil?
    unauthorized unless ((current_user.id == coach.id) || current_user.is_super_user?)
  end
end
