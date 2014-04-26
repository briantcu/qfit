class WarmupsController < ApplicationController
  before_action :set_warmup, only: [:show, :edit, :update, :destroy]

  # GET /warmups
  # GET /warmups.json
  def index
    @warmups = Warmup.all
  end

  # GET /warmups/1
  # GET /warmups/1.json
  def show
  end

  # GET /warmups/new
  def new
    @warmup = Warmup.new
  end

  # GET /warmups/1/edit
  def edit
  end

  # POST /warmups
  # POST /warmups.json
  def create
    @warmup = Warmup.new(warmup_params)

    respond_to do |format|
      if @warmup.save
        format.html { redirect_to @warmup, notice: 'Warmup was successfully created.' }
        format.json { render action: 'show', status: :created, location: @warmup }
      else
        format.html { render action: 'new' }
        format.json { render json: @warmup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warmups/1
  # PATCH/PUT /warmups/1.json
  def update
    respond_to do |format|
      if @warmup.update(warmup_params)
        format.html { redirect_to @warmup, notice: 'Warmup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @warmup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warmups/1
  # DELETE /warmups/1.json
  def destroy
    @warmup.destroy
    respond_to do |format|
      format.html { redirect_to warmups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warmup
      @warmup = Warmup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warmup_params
      params.require(:warmup).permit(:name, :is_stretch, :video_link)
    end
end
