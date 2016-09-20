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

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || determine_redirect(resource)
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, status: :unauthorized
  end

  def verify_logged_in
    unauthorized unless current_user.present?
  end

  def verify_logged_in_html
    redirect_to('/sign-in') unless current_user.present?
  end

  def determine_redirect(user)
    if (user.user_name.blank? || user.sex.blank?) && (user.level != 5) # || user.email.blank?
      '/more-info'
    elsif (user.program_type.blank?) || (user.user_schedule.blank?) ||  user.user_schedule.invalid? || user.hor_push_max.blank?
      '/setup/goal'
    elsif user.level == 5 # coach
      '/coach'
    else
      '/workout'
    end
  end
end
