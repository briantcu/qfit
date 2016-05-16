class ApplicationController < ActionController::Base

  #protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    authenticate_with_http_basic do |username,password|
      if password.present?
        resource = User.find_by_email(username)
        if resource && resource.valid_password?(password)
          sign_in resource, store: false
        end
      else
        resource = User.find_by_authentication_token(username)
        if resource.present?
          sign_in resource, store: false
        end
      end
    end
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, status: :unauthorized
  end

  def verify_logged_in
    unauthorized unless current_user.present?
  end

  def verify_logged_in_html
    redirect_to('/login') unless current_user.present?
  end

end
