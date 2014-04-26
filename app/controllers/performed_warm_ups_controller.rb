class PerformedWarmUpsController < ApplicationController
  before_action :set_performed_warm_up, only: [:show, :edit, :update, :destroy]

  # GET /performed_warm_ups
  # GET /performed_warm_ups.json
  def index
    @performed_warm_ups = PerformedWarmUp.all
  end

  # GET /performed_warm_ups/1
  # GET /performed_warm_ups/1.json
  def show
  end

  # GET /performed_warm_ups/new
  def new
    @performed_warm_up = PerformedWarmUp.new
  end

  # GET /performed_warm_ups/1/edit
  def edit
  end

  # POST /performed_warm_ups
  # POST /performed_warm_ups.json
  def create
    @performed_warm_up = PerformedWarmUp.new(performed_warm_up_params)

    respond_to do |format|
      if @performed_warm_up.save
        format.html { redirect_to @performed_warm_up, notice: 'Performed warm up was successfully created.' }
        format.json { render action: 'show', status: :created, location: @performed_warm_up }
      else
        format.html { render action: 'new' }
        format.json { render json: @performed_warm_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performed_warm_ups/1
  # PATCH/PUT /performed_warm_ups/1.json
  def update
    respond_to do |format|
      if @performed_warm_up.update(performed_warm_up_params)
        format.html { redirect_to @performed_warm_up, notice: 'Performed warm up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @performed_warm_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performed_warm_ups/1
  # DELETE /performed_warm_ups/1.json
  def destroy
    @performed_warm_up.destroy
    respond_to do |format|
      format.html { redirect_to performed_warm_ups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performed_warm_up
      @performed_warm_up = PerformedWarmUp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performed_warm_up_params
      params.require(:performed_warm_up).permit(:routine_id, :warmup_id, :status, :group_warmup_id, :completed)
    end
end
