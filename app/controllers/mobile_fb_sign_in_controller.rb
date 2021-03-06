class MobileFbSignInController < Devise::OmniauthCallbacksController
  before_filter :check_token

  def sign_in_up
    params = OpenStruct.new
    params.provider = 'facebook'
    params.uid = user_params[:uid]

    params.info = OpenStruct.new
    params.info.image = user_params[:image]
    params.info.first_name = user_params[:first_name]
    params.info.last_name = user_params[:last_name]
    params.info.sex = user_params[:gender]
    params.info.email = user_params[:email]
    params.info.user_name = user_params[:user_name]

    @user = User.from_omniauth(params)

    Rails.logger.info('Facebook sign in/up from iOS for user uid: ' + @user.uid)
    Rails.logger.info(params)

    if @user.persisted?
      # User exists and is logging in
      sign_in @user, :event => :authentication # this will throw if @user is not activated
      # Make sure some routines get created if the user hasn't logged in in a while
      session_service = SessionService.new(session)
      session_service.set_current_user_id(@user.id)
      session_service.set_viewing('user') unless @user.is_coach?
      if RoutineService.get_open_workouts_start_today(@user).count == 0 && !@user.is_coach?
        RoutineService.new(@user, 'CRON', Time.zone.today).create_routines
      end
      Analytics.track(
          user_id: "#{@user.id}",
          event: 'Logged In',
          properties: { facebook: true }
      )
      render json: {success: true, token: @user.authentication_token, user_id: @user.id, user_name: @user.user_name, new_user: false} and return
    else

      Rails.logger.info(@user.attributes)
      # User is signing up
      begin
        session_service = SessionService.new(session)
        @user = RegistrationService.instance.register_user(@user, nil, 'user', session_service)
        sign_in @user
      rescue => e
        # Maybe an error if we don't get an email from FB
        Rollbar.error(e)
        Rails.logger.error(e)
        Rails.logger.error(@user)
        render json: {errors: @user.errors.full_messages.uniq}, status: 422
      else
        render json: {success: true, token: @user.authentication_token, user_id: @user.id, user_name: @user.user_name, new_user: true} and return
      end

    end
  end

  private

  def check_token
    fb_token = params[:fb_token]
    return unauthorized unless fb_token.present?
    begin
      user = FbGraph2::User.new(params['uid']).authenticate(fb_token)
      user.fetch
    rescue => e
      Rails.logger.error(e)
      return unauthorized
    end
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, status: :unauthorized
  end

  def user_params
    params.permit(:email, :first_name, :last_name, :gender, :user_name, :uid, :image, :fb_token)
  end
end
