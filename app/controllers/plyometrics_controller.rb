class PlyometricsController < ApplicationController
  before_action :set_plyometric, only: [:show, :edit, :update, :destroy]

  # GET /plyometrics
  # GET /plyometrics.json
  def index
    @plyometrics = Plyometric.all
  end

  # GET /plyometrics/1
  # GET /plyometrics/1.json
  def show
  end

  # GET /plyometrics/new
  def new
    @plyometric = Plyometric.new
  end

  # GET /plyometrics/1/edit
  def edit
  end

  # POST /plyometrics
  # POST /plyometrics.json
  def create
    @plyometric = Plyometric.new(plyometric_params)

    respond_to do |format|
      if @plyometric.save
        format.html { redirect_to @plyometric, notice: 'Plyometric was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plyometric }
      else
        format.html { render action: 'new' }
        format.json { render json: @plyometric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plyometrics/1
  # PATCH/PUT /plyometrics/1.json
  def update
    respond_to do |format|
      if @plyometric.update(plyometric_params)
        format.html { redirect_to @plyometric, notice: 'Plyometric was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plyometric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plyometrics/1
  # DELETE /plyometrics/1.json
  def destroy
    @plyometric.destroy
    respond_to do |format|
      format.html { redirect_to plyometrics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plyometric
      @plyometric = Plyometric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plyometric_params
      params.require(:plyometric).permit(:name, :video_link, :recommended)
    end
end
