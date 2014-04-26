class OneRepMaxesController < ApplicationController
  before_action :set_one_rep_max, only: [:show, :edit, :update, :destroy]

  # GET /one_rep_maxes
  # GET /one_rep_maxes.json
  def index
    @one_rep_maxes = OneRepMax.all
  end

  # GET /one_rep_maxes/1
  # GET /one_rep_maxes/1.json
  def show
  end

  # GET /one_rep_maxes/new
  def new
    @one_rep_max = OneRepMax.new
  end

  # GET /one_rep_maxes/1/edit
  def edit
  end

  # POST /one_rep_maxes
  # POST /one_rep_maxes.json
  def create
    @one_rep_max = OneRepMax.new(one_rep_max_params)

    respond_to do |format|
      if @one_rep_max.save
        format.html { redirect_to @one_rep_max, notice: 'One rep max was successfully created.' }
        format.json { render action: 'show', status: :created, location: @one_rep_max }
      else
        format.html { render action: 'new' }
        format.json { render json: @one_rep_max.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /one_rep_maxes/1
  # PATCH/PUT /one_rep_maxes/1.json
  def update
    respond_to do |format|
      if @one_rep_max.update(one_rep_max_params)
        format.html { redirect_to @one_rep_max, notice: 'One rep max was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @one_rep_max.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /one_rep_maxes/1
  # DELETE /one_rep_maxes/1.json
  def destroy
    @one_rep_max.destroy
    respond_to do |format|
      format.html { redirect_to one_rep_maxes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_one_rep_max
      @one_rep_max = OneRepMax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def one_rep_max_params
      params.require(:one_rep_max).permit(:rep, :percentage)
    end
end
