class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # User exists and is logging in
      sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
    else

      # User is signing up
      begin
        is_coach = request.env['omniauth.params']['coach'].present?

        if is_coach # no more info needed for coach, so create user and sign in
          @user = RegistrationService.instance.register_user(@user, nil, 'coach')
          sign_in @user
        else
          # Stash the user attributes so we can create the account after getting more info
          SessionService.instance.session = session
          SessionService.instance.set_onboarding_user(@user.attributes)
        end

      rescue => e
        # Maybe an error if we don't get an email from FB
        Rollbar.error(e)
          #@TODO process the error for the user
      else

        if is_coach
          redirect_to '/setup-coach'
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