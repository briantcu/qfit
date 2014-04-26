class LapsController < ApplicationController
  before_action :set_lap, only: [:show, :edit, :update, :destroy]

  # GET /laps
  # GET /laps.json
  def index
    @laps = Lap.all
  end

  # GET /laps/1
  # GET /laps/1.json
  def show
  end

  # GET /laps/new
  def new
    @lap = Lap.new
  end

  # GET /laps/1/edit
  def edit
  end

  # POST /laps
  # POST /laps.json
  def create
    @lap = Lap.new(lap_params)

    respond_to do |format|
      if @lap.save
        format.html { redirect_to @lap, notice: 'Lap was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lap }
      else
        format.html { render action: 'new' }
        format.json { render json: @lap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laps/1
  # PATCH/PUT /laps/1.json
  def update
    respond_to do |format|
      if @lap.update(lap_params)
        format.html { redirect_to @lap, notice: 'Lap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laps/1
  # DELETE /laps/1.json
  def destroy
    @lap.destroy
    respond_to do |format|
      format.html { redirect_to laps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lap
      @lap = Lap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lap_params
      params.require(:lap).permit(:lap_number, :performed_sprint_id, :completed)
    end
end
