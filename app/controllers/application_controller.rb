class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!

  private

  def authenticate_user_from_token!
    user_email = params[:email].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:token])
      sign_in user, store: false
    end
  end

end
