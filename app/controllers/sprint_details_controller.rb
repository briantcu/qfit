class SprintDetailsController < ApplicationController
  before_action :set_sprint_detail, only: [:show, :edit, :update, :destroy]

  # GET /sprint_details
  # GET /sprint_details.json
  def index
    @sprint_details = SprintDetail.all
  end

  # GET /sprint_details/1
  # GET /sprint_details/1.json
  def show
  end

  # GET /sprint_details/new
  def new
    @sprint_detail = SprintDetail.new
  end

  # GET /sprint_details/1/edit
  def edit
  end

  # POST /sprint_details
  # POST /sprint_details.json
  def create
    @sprint_detail = SprintDetail.new(sprint_detail_params)

    respond_to do |format|
      if @sprint_detail.save
        format.html { redirect_to @sprint_detail, notice: 'Sprint detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sprint_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @sprint_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sprint_details/1
  # PATCH/PUT /sprint_details/1.json
  def update
    respond_to do |format|
      if @sprint_detail.update(sprint_detail_params)
        format.html { redirect_to @sprint_detail, notice: 'Sprint detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sprint_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprint_details/1
  # DELETE /sprint_details/1.json
  def destroy
    @sprint_detail.destroy
    respond_to do |format|
      format.html { redirect_to sprint_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sprint_detail
      @sprint_detail = SprintDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprint_detail_params
      params.require(:sprint_detail).permit(:detail)
    end
end
