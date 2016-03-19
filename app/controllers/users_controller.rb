class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_email]
  before_filter :verify_is_logged_in, only: [:change_email]
  before_filter :auth_for_user_update, only: [:update]
  before_filter :auth_for_progress, only: [:get_progress]
  before_filter :auth_for_fitness_submission, only: [:fitness_assessment]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(convert_data_uri_to_upload(user_params))
      format.json { head :no_content }
    else
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  #GET /users/:user_id/calendar/year/:year_id/month/:month_id
  def get_calendar
    @calendar = UserCalendar.new(:user_id => params[:user_id], :month_id => params[:month_id], :year_id => params[:year_id])
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
      render action: 'show', status: :ok, location: @user
    else
      render json: @fitness_assessment_submission.errors, status: :unprocessable_entity
    end
  end

  #PUT /users/1/change_email
  def change_email
    if @user.valid_password?(params[:user][:password]) && (params[:user][:email] == params[:user][:new_email])
      @user.update_email(params[:user][:email])
      render action: 'show', status: :ok, location: @user
    else
      unauthorized
    end
  end

  def get_progress
    user_id = params[:id]
    chart_type = params[:chart_type]
    period = params[:period]
    exercise_id = params[:exercise_id] rescue nil
    ProgressService.new(user_id, chart_type, period, exercise_id).get_chart
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:master_user_id, :first_name, :last_name, :email, :sex, :administrator, :sub_user,
                                 :knee_dom_max, :hor_push_max, :hor_pull_max, :power_index, :current_phase, :phone,
                                 :last_weight_day_created, :last_warmup_day_created, :last_plyometric_day_created,
                                 :last_sprint_day_created, :user_name, :sprint_diff, :weight, :level, :program_type,
                                 :birth_year, :subscription_date, :displayed_user_name)
  end

  def fitness_assessment_params
    params.require(:fitness_assessment_submission).permit(:user_id, :weight, :bench_reps, :bench_weight, :squat_reps, :squat_weight, :pull_ups, :push_ups, :assisted_push_ups, :experience_level, :sex, :first_name, :last_name)
  end

  def auth_for_user_update
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.id == params[:user_schedule][:user_id].to_i ||
            (current_user.is_coach_of_user(params[:user_schedule][:user_id].to_i)) ||
            (current_user.is_super_user))
  end

  def verify_is_logged_in
    unauthorized unless !current_user.nil? && (current_user.id == @user.id)
  end

  def auth_for_fitness_submission
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.id == params[:fitness_assessment_submission][:user_id].to_i ||
            (current_user.is_coach_of_user(params[:fitness_assessment_submission][:user_id].to_i)) ||
            (current_user.is_super_user))
  end

  def auth_for_progress
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.id == params[:id].to_i ||
            (current_user.is_coach_of_user(params[:id].to_i)) ||
            (current_user.is_super_user))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end

  def change_email_params
    params.require(:user).permit(:password, :email, :new_email)
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

      obj_hash[:avatars] = uploaded_file
      obj_hash.delete(:image_url)
    end
    obj_hash
  end

end
