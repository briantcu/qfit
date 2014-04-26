class PerformedPlyometricsController < ApplicationController
  before_action :set_performed_plyometric, only: [:show, :edit, :update, :destroy]

  # GET /performed_plyometrics
  # GET /performed_plyometrics.json
  def index
    @performed_plyometrics = PerformedPlyometric.all
  end

  # GET /performed_plyometrics/1
  # GET /performed_plyometrics/1.json
  def show
  end

  # GET /performed_plyometrics/new
  def new
    @performed_plyometric = PerformedPlyometric.new
  end

  # GET /performed_plyometrics/1/edit
  def edit
  end

  # POST /performed_plyometrics
  # POST /performed_plyometrics.json
  def create
    @performed_plyometric = PerformedPlyometric.new(performed_plyometric_params)

    respond_to do |format|
      if @performed_plyometric.save
        format.html { redirect_to @performed_plyometric, notice: 'Performed plyometric was successfully created.' }
        format.json { render action: 'show', status: :created, location: @performed_plyometric }
      else
        format.html { render action: 'new' }
        format.json { render json: @performed_plyometric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performed_plyometrics/1
  # PATCH/PUT /performed_plyometrics/1.json
  def update
    respond_to do |format|
      if @performed_plyometric.update(performed_plyometric_params)
        format.html { redirect_to @performed_plyometric, notice: 'Performed plyometric was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @performed_plyometric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performed_plyometrics/1
  # DELETE /performed_plyometrics/1.json
  def destroy
    @performed_plyometric.destroy
    respond_to do |format|
      format.html { redirect_to performed_plyometrics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performed_plyometric
      @performed_plyometric = PerformedPlyometric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performed_plyometric_params
      params.require(:performed_plyometric).permit(:plyometric_id, :routine_id, :status, :group_performed_plyometric_id, :performed_one, :performed_two, :performed_three)
    end
end
