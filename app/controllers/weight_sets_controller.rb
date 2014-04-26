class WeightSetsController < ApplicationController
  before_action :set_weight_set, only: [:show, :edit, :update, :destroy]

  # GET /weight_sets
  # GET /weight_sets.json
  def index
    @weight_sets = WeightSet.all
  end

  # GET /weight_sets/1
  # GET /weight_sets/1.json
  def show
  end

  # GET /weight_sets/new
  def new
    @weight_set = WeightSet.new
  end

  # GET /weight_sets/1/edit
  def edit
  end

  # POST /weight_sets
  # POST /weight_sets.json
  def create
    @weight_set = WeightSet.new(weight_set_params)

    respond_to do |format|
      if @weight_set.save
        format.html { redirect_to @weight_set, notice: 'Weight set was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weight_set }
      else
        format.html { render action: 'new' }
        format.json { render json: @weight_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weight_sets/1
  # PATCH/PUT /weight_sets/1.json
  def update
    respond_to do |format|
      if @weight_set.update(weight_set_params)
        format.html { redirect_to @weight_set, notice: 'Weight set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weight_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_sets/1
  # DELETE /weight_sets/1.json
  def destroy
    @weight_set.destroy
    respond_to do |format|
      format.html { redirect_to weight_sets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_set
      @weight_set = WeightSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_set_params
      params.require(:weight_set).permit(:set_num, :performed_exercise_id, :rec_weight, :rec_reps, :perf_weight, :perf_reps)
    end
end
