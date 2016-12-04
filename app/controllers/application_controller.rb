class ApplicationController < ActionController::Base

  #protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    authenticate_with_http_basic do |username,password|
      if password.present?
        resource = User.where('lower(email) = ?', username.downcase).first
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

    store_location_for(:user, request.fullpath)
    redirect_to('/sign-in') unless current_user.present?
  end

  def determine_redirect(user)
    if (user.user_name.blank? || user.sex.blank?) && (!user.is_coach?) # || user.email.blank?
      '/more-info'
    elsif user.is_coach?
      '/coach'
    elsif user.needs_setup?
      '/setup/goal'
    else
      '/workout'
    end
  end
end
