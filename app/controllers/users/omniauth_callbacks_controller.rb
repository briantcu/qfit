class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      @user.save
      sign_in @user
      session[:current_user_id] = @user.id
      session[:user_id] = @user.id
      redirect_to '/more-info'
    end
  end

  def failure
    redirect_to root_path
  end
end