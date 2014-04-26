class SignUpCodesController < ApplicationController
  before_action :set_sign_up_code, only: [:show, :edit, :update, :destroy]

  # GET /sign_up_codes
  # GET /sign_up_codes.json
  def index
    @sign_up_codes = SignUpCode.all
  end

  # GET /sign_up_codes/1
  # GET /sign_up_codes/1.json
  def show
  end

  # GET /sign_up_codes/new
  def new
    @sign_up_code = SignUpCode.new
  end

  # GET /sign_up_codes/1/edit
  def edit
  end

  # POST /sign_up_codes
  # POST /sign_up_codes.json
  def create
    @sign_up_code = SignUpCode.new(sign_up_code_params)

    respond_to do |format|
      if @sign_up_code.save
        format.html { redirect_to @sign_up_code, notice: 'Sign up code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sign_up_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @sign_up_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sign_up_codes/1
  # PATCH/PUT /sign_up_codes/1.json
  def update
    respond_to do |format|
      if @sign_up_code.update(sign_up_code_params)
        format.html { redirect_to @sign_up_code, notice: 'Sign up code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sign_up_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sign_up_codes/1
  # DELETE /sign_up_codes/1.json
  def destroy
    @sign_up_code.destroy
    respond_to do |format|
      format.html { redirect_to sign_up_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sign_up_code
      @sign_up_code = SignUpCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_up_code_params
      params.require(:sign_up_code).permit(:code, :user_id, :email)
    end
end
