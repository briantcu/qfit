class WorkoutManagementController < ApplicationController
  before_action :verify_logged_in_html
  before_action :set_current_user
  before_action :can_access_user
  before_action :verify_coach_session_present, except: [:setup_coach]
  before_action :has_min_info, only: [:do_work]
  before_action :set_gon_info

  def setup_goal
    # This is needed if they're redirected after login via FB
    evaluate_context
    render template: 'pages/setup'
  end

  def setup_quads
    render template: 'pages/setup'
  end

  def setup_coach
    render template: 'pages/setup'
  end

  def fitness
    # only sub users can navigate directly to here
    unless @user.sub_user
      setup_redirect and return
    end
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
            routine: routine
        }
    )
    render template: 'pages/do_work'
  end

  #/commitment /program
  def setup_redirect
    if session[:setup_context] == 'user' || session[:setup_context] == 'coach_sub' || (session[:setup_context].blank? && session[:viewing] != 'team')
      redirect_to '/setup/goal'
    else
      redirect_to '/setup/quads'
    end
  end

  private

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

    if session[:viewing] == 'team'
      team = Group.find(session[:team_id])
      if team.group_schedule.blank? || team.group_schedule.invalid?
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

  def verify_coach_session_present
    return unless current_user.is_coach?
    if session[:viewing].blank?
      redirect_to '/coach?choose=' and return
    end
    if session[:viewing] == 'user' and session[:current_user_id].blank?
      redirect_to '/coach?choose=' and return
    end

    if session[:viewing] == 'team' and session[:team_id].blank?
      redirect_to '/coach?choose='
    end
  end

  def evaluate_context
    if @user.needs_setup? && session[:setup_context].blank?
      session_service = SessionService.new(session)
      if @user.is_sub_user?
        session_service.set_setup_context('sub_user')
      else
        session_service.set_setup_context('user')
      end

      gon.push({setup_context: session[:setup_context]})

      if @user.hor_pull_max.blank?
        session_service.set_onboarding(true)
        gon.push({onboarding: true})
      end
    end
  end

  def set_gon_info
    viewing = session[:viewing] || 'user'
    gon.push(
        {
            current_user_id: @user.id,
            user_id: current_user.id,
            is_coach: current_user.is_coach?,
            is_sub_user: current_user.is_sub_user?,
            is_individual: current_user.is_individual?,
            coach_account_id: current_user.coach_account.try(:id),
            team_id: session[:team_id],
            viewing: viewing,
            setup_context: session[:setup_context],
            onboarding: session[:onboarding],
            has_premium_access: @user.has_premium_access?
        }
    )
  end
end