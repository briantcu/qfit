class CoachAccountsController < ApplicationController
  before_action :set_coach_account, only: [:show, :edit, :update, :destroy]

  # GET /coach_accounts
  # GET /coach_accounts.json
  def index
    @coach_accounts = CoachAccount.all
  end

  # GET /coach_accounts/1
  # GET /coach_accounts/1.json
  def show
  end

  # GET /coach_accounts/new
  def new
    @coach_account = CoachAccount.new
  end

  # GET /coach_accounts/1/edit
  def edit
  end

  # POST /coach_accounts
  # POST /coach_accounts.json
  def create
    @coach_account = CoachAccount.new(coach_account_params)

    respond_to do |format|
      if @coach_account.save
        format.html { redirect_to @coach_account, notice: 'Coach account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coach_account }
      else
        format.html { render action: 'new' }
        format.json { render json: @coach_account.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /coach_accounts/1
  # DELETE /coach_accounts/1.json
  def destroy
    @coach_account.destroy
    respond_to do |format|
      format.html { redirect_to coach_accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_account
      @coach_account = CoachAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coach_account_params
      params.require(:coach_account).permit(:user_id, :num_accts, :billing_email)
    end
end
