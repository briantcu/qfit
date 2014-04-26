class SentCodesController < ApplicationController
  before_action :set_sent_code, only: [:show, :edit, :update, :destroy]

  # GET /sent_codes
  # GET /sent_codes.json
  def index
    @sent_codes = SentCode.all
  end

  # GET /sent_codes/1
  # GET /sent_codes/1.json
  def show
  end

  # GET /sent_codes/new
  def new
    @sent_code = SentCode.new
  end

  # GET /sent_codes/1/edit
  def edit
  end

  # POST /sent_codes
  # POST /sent_codes.json
  def create
    @sent_code = SentCode.new(sent_code_params)

    respond_to do |format|
      if @sent_code.save
        format.html { redirect_to @sent_code, notice: 'Sent code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sent_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @sent_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sent_codes/1
  # PATCH/PUT /sent_codes/1.json
  def update
    respond_to do |format|
      if @sent_code.update(sent_code_params)
        format.html { redirect_to @sent_code, notice: 'Sent code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sent_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sent_codes/1
  # DELETE /sent_codes/1.json
  def destroy
    @sent_code.destroy
    respond_to do |format|
      format.html { redirect_to sent_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sent_code
      @sent_code = SentCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sent_code_params
      params.require(:sent_code).permit(:code, :receiver, :used)
    end
end
