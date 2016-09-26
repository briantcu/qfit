class PagesController < ApplicationController
  before_action :verify_logged_in_html, only: [:setup, :coaches, :schedule, :do_work, :account]
  before_action :set_current_user, only: [:do_work, :setup, :schedule, :account, :coaches]
  before_action :can_access_user, only: [:setup, :coaches, :schedule, :do_work]
  before_action :set_gon_info, only: [:setup, :coaches, :schedule, :do_work, :account]
  before_action :has_min_info, only: [:do_work]
  before_action :save_sign_up_code_in_session, only: [:sign_up]
  before_action :set_gon_setup_context, only: [:setup, :schedule, :do_work]

  def home
    render template: 'pages/home'
  end


  ########## SIGN IN/UP
  def sign_up
    gon.push(
        {
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end

  def sign_up_coach
    render layout: 'full_page'
  end

  def login
    render layout: 'full_page'
  end

  def forgot
    render layout: 'full_page'
  end

  def more_info
    onboarding_user_light = {}
    onboarding_user_light[:first_name] = session[:onboarding_user]['first_name']
    onboarding_user_light[:last_name] = session[:onboarding_user]['last_name']
    onboarding_user_light[:email] = session[:onboarding_user]['email']
    gon.push(
        {
            onboarding_user: onboarding_user_light,
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end


  ############### SETUP
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


  ######### PAGES
  def account
    render template: 'pages/account'
  end

  def coaches
    render template: 'pages/coaches'
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

  def leaders
    gon.push(
        {
            current_user_id: current_user.id
        }
    )
    render template: 'pages/leaders'
  end

  def setup_redirect
    if session[:setup_context] == 'user' || session[:setup_context] == 'coach_sub' || session[:setup_context].blank?
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

  def save_sign_up_code_in_session
    if params[:qfcode]
      session_service = SessionService.new(session)
      session_service.set_sign_up_code(params[:qfcode])
    end
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