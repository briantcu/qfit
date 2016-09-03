class PagesController < ApplicationController
  before_action :set_athlete, only: [:do_work]
  before_filter :verify_logged_in_html, only: [:setup, :coaches, :schedule, :do_work, :profile]
  before_filter :can_access_user, only: [:setup, :coaches, :schedule, :do_work]
  before_filter :has_min_info, only: [:do_work]

  def home
    render template: 'pages/home'
  end


  ########## SIGN IN/UP
  def sign_up
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
    gon.push({
                 new_user: session["devise.facebook_user"]
             })
    render layout: 'full_page'
  end



  ############### SETUP
  def setup
    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id
             })
    render template: 'pages/setup'
  end

  def setup_coach
    gon.push({
                 current_user_id: current_user.id
             })
    render template: 'pages/setup_coach'
  end

  def schedule
    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id
             })
    render template: 'pages/setup'
  end


  ######### PAGES
  def account
    gon.push({
                 current_user_id: current_user.id
             })
    render template: 'pages/account'
  end

  def coaches
    gon.push({
                 current_user_id: current_user.id,
                 coach_account_id: current_user.coach_account.id
             })
    render template: 'pages/coaches'
  end

  def do_work
    routine = nil
    if params[:year].present?
      routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], @user.id)
    end

    gon.push({
                 current_user_id: @user.id,
                 routine: routine
             })
    render template: 'pages/do_work'
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


end