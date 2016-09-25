# current_user_id - ID of user you're operating on. Not necessarily the current_user, if the current_user is a coach
# current_team_id
# sign_up_code - set when the user enters the site with 'qfcode' param
# onboarding_user - set when the user signs up with FB but we need more info. hash of the user attributes
# onboarding - boolean indicating whether or not the user is in the onboarding flow. if false, then updating the workout plan
# viewing - team vs user. used to determine which endpoints to use to fetch user data. Also how to display do-work
# setup_context - user, sub_user, coach_sub, coach_team - used to determine the flow during setup, routes etc.


class SessionService
  attr_accessor :session

  def initialize(session)
    self.session = session
  end

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

  def set_team_id(id)
    session[:team_id] = id
  end
end