class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # User exists and is logging in
      sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
    else

      # User is signing up
      begin
        session_service = SessionService.new(session)
        is_coach = request.env['omniauth.params']['coach'].present?

        if is_coach # no more info needed for coach, so create user and sign in
          @user = RegistrationService.instance.register_user(@user, nil, 'coach', session_service)
          session_service.set_onboarding_user(@user.attributes)
          sign_in @user
        else
          # Stash the user attributes so we can create the account after getting more info
          session_service.set_onboarding_user(@user.attributes)
        end

      rescue => e
        # Maybe an error if we don't get an email from FB
        Rollbar.error(e)
        Qfit::Application.logger.error(e)
        Qfit::Application.logger.error(@user)
      else

        if is_coach
          redirect_to '/setup/coach'
        else
          redirect_to '/more-info'
        end

      end
    end
  end

  def failure
    redirect_to '/sign-in'
  end
end