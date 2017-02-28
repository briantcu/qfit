class PagesController < ApplicationController
  before_action :verify_logged_in_html, only: [:coaches, :account]
  before_action :verify_is_coach, only: [:coaches]
  before_action :set_gon_info, only: [:coaches, :account]
  before_action :clear_coach_session, only: [:home, :coaches]

  def home
    if current_user
      redirect_to(determine_redirect(current_user)) and return
    end
    render template: 'pages/home'
  end

  def account
    gon.push({stripe_key: Qfit::Application.config.stripe_key})
    render template: 'pages/account'
  end

  def profile
    @user = User.find_by(user_name: params[:user_name])
    if @user.blank?
      render :file => 'public/404.html', :status => :not_found, :layout => false
      return
    end
    if @user.is_coach?
      redirect_to '/workout' and return
    end
    gon.push ({
        user_id: current_user.try(:id),
        current_user_id: @user.id,
        email: current_user.try(:email),
        first_name: current_user.try(:first_name),
        last_name: current_user.try(:last_name)
    })
    render template: 'pages/profile'
  end

  def coaches
    render template: 'pages/coaches'
  end

  def leaders
    render template: 'pages/leaders'
  end

  def terms
    render template: 'pages/terms'
  end

  def shared_workout
    uuid = params[:t]
    routine = DailyRoutine.routine_from_token(uuid)
    gon.push ({
        routine: routine,
        user_name: routine.user.user_name,
        user_id: current_user.try(:id),
        token: params[:t],
        email: current_user.try(:email),
        first_name: current_user.try(:first_name),
        last_name: current_user.try(:last_name)
    })
    render template: 'pages/shared'
  end

  private

  def verify_is_coach
    unless current_user.is_coach?
      redirect_to '/'
    end
  end

  def clear_coach_session
    if current_user && current_user.is_coach?
      # Get ouf of a possible weird state if they bail out of onboarding
      session_service = SessionService.new(session)
      session_service.set_setup_context(nil)
      session_service.set_onboarding(false)
      session_service.set_viewing(nil)
      session_service.set_team_id(nil)
      session_service.set_current_user_id(nil)
    end
  end

  def set_gon_info
    gon.push(
        {
            current_user_id: current_user.try(:id),
            user_id: current_user.try(:id),
            is_coach: current_user.is_coach?,
            is_sub_user: current_user.is_sub_user?,
            is_individual: current_user.is_individual?,
            coach_account_id: current_user.coach_account.try(:id),
            email: current_user.try(:email),
            first_name: current_user.try(:first_name),
            last_name: current_user.try(:last_name)
        }
    )
  end
end