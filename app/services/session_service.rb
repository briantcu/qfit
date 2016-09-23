require 'singleton'

class SessionService
  include Singleton

  def set_current_user_id(id)
    session[:current_user_id] = id
  end

  def set_sign_up_code(code)
    session[:sign_up_code] = code
  end

  def set_onboarding_user(user_attributes)
    session[:onboarding_user] = user_attributes
  end

end