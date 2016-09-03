class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      begin
        @user.save!
      rescue => e
        # Maybe an error if we don't get an email from FB
        Rollbar.error(e)
          #@TODO process the error for the user
      else
        sign_in @user
        session[:current_user_id] = @user.id
        session[:user_id] = @user.id
        redirect_to '/more-info'
      end
    end
  end

  def failure
    redirect_to '/sign-in'
  end
end