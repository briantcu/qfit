class PagesController < ApplicationController
  before_action :verify_logged_in_html, only: [:setup, :coaches, :schedule, :do_work, :account]
  before_action :can_access_user, only: [:setup, :coaches, :schedule, :do_work]
  before_action :set_athlete, only: [:do_work]
  before_action :set_gon_info, only: [:setup, :coaches, :schedule, :do_work, :account]
  before_action :has_min_info, only: [:do_work]
  before_action :save_sign_up_code_in_session, only: [:sign_up]

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
    if params[:year].present?
      routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], @user.id)
    end

    gon.push(
        {
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
    redirect_to '/setup/goal'
  end

  private

  def has_min_info
    if (@user.program_type.blank?) || (@user.user_schedule.blank?) ||  @user.user_schedule.invalid? || @user.hor_push_max.blank?
      setup_redirect
    end
  end

  def set_athlete
    current_user_id = session[:current_user_id] || current_user.id
    @user = User.find(current_user_id)
  end

  def can_access_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == session[:current_user_id] ||
        (current_user.is_coach_of_user?(session[:current_user_id])) ||
        (current_user.is_super_user?))
  end

  def save_sign_up_code_in_session
    if params[:qfcode]
      SessionService.instance.session = session
      SessionService.instance.set_sign_up_code(params[:qfcode])
    end
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