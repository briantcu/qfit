require 'singleton'

# current_user_id - ID of user you're operating on. Not necessarily the current_user, if the current_user is a coach
# current_team_id
# sign_up_code - set when the user enters the site with 'qfcode' param
# onboarding_user - set when the user signs up with FB but we need more info. hash of the user attributes
# onboarding - boolean indicating whether or not the user is in the onboarding flow
# viewing - team vs user
# setup_context - user, subUser, coachSub, coachTeam - used to determine the flow during setup


class SessionService
  include Singleton

  attr_accessor :session

  def set_current_user_id(id)
    session[:current_user_id] = id
  end

  def set_sign_up_code(code)
    session[:sign_up_code] = code
  end

  def set_onboarding_user(user_attributes)
    session[:onboarding_user] = user_attributes
  end

  def set_onboarding(onboarding)
    session[:onboarding] = onboarding
  end

  def set_current_team_id(id)
    session[:current_team_id] = id
  end

  def set_viewing(viewing)
    session[:viewing] = viewing
  end

  def set_setup_context(context)
    session[:setup_context] = context
  end
end