class CoachAccountsController < ApplicationController
  before_filter :verify_owns_account, only: [:show, :update]
  before_filter :verify_owns_user, only: [:delete_user]

  # GET /coach_accounts/1
  # GET /coach_accounts/1.json
  def show
  end

  # GET /coach_accounts/1/edit
  def edit
  end

  # PATCH/PUT /coach_accounts/1
  # PATCH/PUT /coach_accounts/1.json
  def update
    respond_to do |format|
      if @coach_account.update(coach_account_params)
        format.html { redirect_to @coach_account, notice: 'Coach account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coach_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    EmailService.coach_deleted_you(user.email)
    user.destroy!
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_coach_account
    @coach_account = CoachAccount.find(params[:id])
  end

  def verify_owns_account
    set_coach_account
    (current_user.nil?) ? unauthorized : unauthorized unless
      @coach_account.user_id == current_user.id
  end

  def verify_owns_user
    (current_user.nil?) ? unauthorized : unauthorized unless
      (current_user.is_coach_of_user(params[:user_id].to_i))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def coach_account_params
    params.require(:coach_account).permit(:user_id, :num_accts, :billing_email)
  end
end
