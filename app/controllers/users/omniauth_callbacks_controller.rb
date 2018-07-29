class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    Rails.logger.info('Facebook sign in/up for user uid: ' + @user.uid)
    Rails.logger.info(request.env['omniauth.auth'])
    Rails.logger.info(request.env['omniauth.params'])
    if @user.persisted?
      # User exists and is logging in
      Analytics.identify(
          user_id: "#{@user.id}",
          traits: { email: "#{ @user.email }", level: @user.level, first_name: "#{@user.first_name}", last_name: "#{@user.last_name}" },
      )
      Analytics.track(
          user_id: "#{@user.id}",
          event: 'Logged In',
          properties: { facebook: true }
      )
      # Make sure some routines get created if the user hasn't logged in in a while
      if RoutineService.get_open_workouts_start_today(@user).count == 0 && !@user.is_coach?
        RoutineService.new(@user, 'CRON', Time.zone.today).create_routines
      end
      session_service = SessionService.new(session)
      session_service.set_current_user_id(@user.id)
      session_service.set_viewing('user') unless @user.is_coach?
      sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
    else

      Rails.logger.info(@user.attributes)
      # User is signing up
      begin
        session_service = SessionService.new(session)
        is_coach = request.env['omniauth.params']['coach'].present?

        if is_coach # no more info needed for coach, so create user and sign in
          if @user.email.present?
            # Register and continue
            @user = RegistrationService.instance.register_user(@user, nil, 'coach', session_service)
            sign_in @user
          else
            # Save attributes and send to more-info
            @user.administrator = true
            Rails.logger.info('Setting onboarding user for coach')
            session_service.set_onboarding_user(@user.attributes)
          end
        else
          # Stash the user attributes so we can create the account after getting more info
          Rails.logger.info('Setting onboarding user')
          session_service.set_onboarding_user(@user.attributes)
        end

      rescue => e
        # Maybe an error if we don't get an email from FB
        Rollbar.error(e)
        Rails.logger.error(e)
        Rails.logger.error(@user)
      else

        if is_coach && @user.email.present?
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