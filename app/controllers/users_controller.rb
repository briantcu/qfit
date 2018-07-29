# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  master_user_id              :integer
#  first_name                  :string(255)
#  last_name                   :string(255)
#  email                       :string(255)
#  sex                         :string(255)
#  administrator               :boolean          default(FALSE)
#  sub_user                    :boolean
#  knee_dom_max                :float
#  hor_push_max                :float
#  hor_pull_max                :float
#  power_index                 :integer
#  current_phase               :integer
#  phone                       :string(255)
#  last_weight_day_created     :integer          default(0)
#  last_warmup_day_created     :integer          default(0)
#  last_plyometric_day_created :integer          default(0)
#  last_sprint_day_created     :integer          default(0)
#  user_name                   :string(255)
#  sprint_diff                 :integer          default(1)
#  weight                      :float
#  program_type_id             :integer
#  birth_year                  :integer
#  subscription_date           :date
#  created_at                  :datetime
#  updated_at                  :datetime
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  authentication_token        :string(255)
#  experience_level            :integer
#  points                      :integer          default(10)
#  status                      :integer          default(1)
#  paid_tier                   :integer          default(1)
#  facebook                    :string
#  provider                    :string
#  uid                         :string
#  image                       :string
#  stripe_id                   :string
#  active_until                :datetime
#  subscription_id             :string
#  level                       :integer
#  needs_pw_reset              :boolean
#  avatar                      :string
#  failed_attempts             :integer          default(0), not null
#  unlock_token                :string
#  locked_at                   :datetime
#  bio                         :text
#

require "stripe"

class UsersController < ApplicationController
  before_action :verify_logged_in_html, only: [:avatar]
  before_action :set_user, only: [:show, :update, :get_calendar, :fitness_assessment, :get_progress]
  before_filter :can_access_user, only: [:show, :get_calendar, :fitness_assessment, :get_progress]
  before_filter :is_user, only: [:update]

  # GET /users/1.json
  def show
  end

  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def avatar
    file = params[:file]
    current_user.avatar = file
    current_user.save!
    @user = current_user
    render :show
  end

  #GET /users/:id/calendar/year/:year_id/month/:month_id
  def get_calendar
    @calendar = UserCalendar.new(:user_id => params[:id], :month_id => params[:month_id], :year_id => params[:year_id], :is_user => true)
    if @calendar.valid?
      @calendar.populate_calendar
      render :json => @calendar.as_json
    else
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  # POST /users/1/fitness.json
  def fitness_assessment
    @fitness_assessment_submission = FitnessAssessmentSubmission.new(fitness_assessment_params)
    if @fitness_assessment_submission.valid?
      @user = @fitness_assessment_submission.process_submission
      if @user.is_sub_user?
        process_sub_user
        next_routine = DailyRoutine.get_open_workouts_start_today(@user).first
        render action: 'show', status: :ok, location: "/workout/#{next_routine.try(:id)}" and return
      end
      render action: 'show', status: :ok
    else
      render json: @fitness_assessment_submission.errors, status: :unprocessable_entity
    end
  end

  def get_progress
    user_id = params[:id]
    chart_type = params[:chart_type]
    period = params[:period]
    exercise_id = params[:exercise_id]
    if period != '4' && period != '5'
      unless @user.has_premium_access?
        render status: 401, json: {errors: 'You need to upgrade your subscription to be able to do this.'}
      end

    end
    @progress_data = ProgressService.new(user_id, chart_type, period, exercise_id).get_chart
  end

  def username_exists
    username = params[:username]
    user = User.where('lower(user_name) = ?', username.downcase).first
    if user.present?
      head :no_content
    else
      head 404
    end
  end

  def email_exists
    email = params[:email]
    user = User.where('lower(email) = ?', email.downcase).first
    if user.present?
      head :no_content
    else
      head 404
    end
  end

  private

  def process_sub_user
    group = @user.used_sign_up_code.group
    group.add_member(@user)
    RoutineService.group_status_changed(@user)
    session_service = SessionService.new(session)
    session_service.set_setup_context(nil)
    session_service.set_onboarding(false)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :sex, :phone, :user_name, :weight, :birth_year, :password, :password_confirmation, :bio, :experience_level)
  end

  def fitness_assessment_params
    params.require(:fitness_assessment_submission).permit(:user_id, :weight, :bench_reps, :bench_weight, :squat_reps,
                                                          :squat_weight, :pull_ups, :push_ups, :assisted_push_ups,
                                                          :experience_level, :sex, :first_name, :last_name)
  end

  def can_access_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == @user.id ||
        (current_user.is_coach_of_user?(@user.id)) ||
        (current_user.is_super_user?))
    end

  def is_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == @user.id ||
        (current_user.is_super_user?))
  end

  def split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1 # "image/gif"
      uri[:encoder] = $2 # "base64"
      uri[:data] = $3 # data string
      uri[:extension] = $1.split('/')[1] # "gif"
      return uri
    else
      return nil
    end
  end

  def convert_data_uri_to_upload(obj_hash)
    if obj_hash[:image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$})
      image_data = split_base64(obj_hash[:image_url])
      image_data_string = image_data[:data]
      image_data_binary = Base64.decode64(image_data_string)

      temp_img_file = Tempfile.new("")
      temp_img_file.binmode
      temp_img_file << image_data_binary
      temp_img_file.rewind

      img_params = {:filename => "image.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
      uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

      obj_hash[:avatar] = uploaded_file
      obj_hash.delete(:image_url)
    end
    obj_hash
  end

end
