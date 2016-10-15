class WorkoutManagementController < ApplicationController
  before_action :verify_logged_in_html, only: [:setup, :schedule, :do_work]
  before_action :set_current_user, only: [:do_work, :setup, :schedule]
  before_action :can_access_user, only: [:setup, :schedule, :do_work]
  before_action :set_gon_info, only: [:setup, :schedule, :do_work]
  before_action :has_min_info, only: [:do_work]
  before_action :set_gon_setup_context, only: [:setup, :schedule, :do_work]

  def setup
    render template: 'pages/setup'
  end

  def schedule
    if session[:viewing] == 'team'
      team = Group.find(session[:team_id])
      if team.group_schedule.blank?
        setup_redirect
        return
      end
    else
      if @user.user_schedule.blank?
        setup_redirect
        return
      end
    end

    render template: 'pages/setup'
  end

  def do_work
    viewing = session[:viewing] || 'user'
    routine = get_routine(viewing)

    gon.push(
        {
            team_id: session[:team_id],
            viewing: viewing,
            routine: routine
        }
    )
    render template: 'pages/do_work'
  end

  private

  def setup_redirect
    if session[:setup_context] == 'user' || session[:setup_context] == 'coach_sub' || session[:setup_context].blank?
      redirect_to '/setup/goal'
    else
      redirect_to '/setup/quads'
    end
  end

  def get_routine(viewing)
    routine = nil

    if viewing == 'user'
      if params[:year].present?
        routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], @user.id)
      elsif params[:workout_id].present?
        routine = DailyRoutine.find(params[:workout_id])
      end
    else
      if params[:year].present?
        routine = GroupRoutine.get_routine_by_date(params[:month], params[:year], params[:day], @user.id)
      elsif params[:workout_id].present?
        routine = GroupRoutine.find(params[:workout_id])
      end
    end
    routine
  end

  def has_min_info
    if session[:viewing] == 'user'
      if (@user.program_type.blank?) || (@user.user_schedule.blank?) ||  @user.user_schedule.invalid? || @user.hor_push_max.blank?
        setup_redirect
      end
    end
  end

  def set_current_user
    current_user_id = session[:current_user_id] || current_user.id
    @user = User.find(current_user_id)
    if session[:current_user_id].blank?
      session_service = SessionService.new(session)
      session_service.set_current_user_id(@user.id)
    end
  end

  def can_access_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == @user.id ||
        (current_user.is_coach_of_user?(@user.id)) ||
        (current_user.is_super_user?))
  end

  def set_gon_setup_context
    viewing = session[:viewing] || 'user'
    gon.push(
        {
            team_id: session[:team_id],
            viewing: viewing,
            setup_context: session[:setup_context],
            onboarding: session[:onboarding]
        }
    )
  end

  def set_gon_info
    gon.push(
        {
            current_user_id: @user.id,
            user_id: current_user.id,
            is_coach: current_user.is_coach?,
            is_sub_user: current_user.is_sub_user?,
            is_individual: current_user.is_individual?,
            coach_account_id: current_user.coach_account.try(:id)
        }
    )
  end
end