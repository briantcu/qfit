class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :auth_for_user_update, only: [:update]
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:master_user_id, :first_name, :last_name, :email, :sex, :administrator, :sub_user, :knee_dom_max, :hor_push_max, :hor_pull_max, :power_index, :password, :current_phase, :phone, :last_weight_day_created, :last_warmup_day_created, :last_plyometric_day_created, :last_sprint_day_created, :user_name, :sprint_diff, :weight, :level, :program_type, :birth_year, :subscription_date)
    end

    def fitness_assessment_params
      params.require(:fitness_assessment_submission).permit(:user_id, :weight, :bench_reps, :bench_weight, :squat_reps, :squat_weight, :pull_ups, :push_ups, :assisted_push_ups, :experience_level, :sex)
    end

    def auth_for_user_update
      (current_user.nil?) ? unauthorized : unauthorized unless
          (current_user.id == params[:user_schedule][:user_id].to_i ||
              (current_user.is_coach_of_user(current_user, params[:user_schedule][:user_id].to_i)) ||
              (current_user.is_super_user))
    end

    def auth_for_fitness_submission
      (current_user.nil?) ? unauthorized : unauthorized unless
          (current_user.id == params[:fitness_assessment_submission][:user_id].to_i ||
              (current_user.is_coach_of_user(current_user, params[:fitness_assessment_submission][:user_id].to_i)) ||
              (current_user.is_super_user))
    end

    def unauthorized
      render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
    end

end
