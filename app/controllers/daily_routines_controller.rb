class DailyRoutinesController < ApplicationController
  before_action :set_daily_routine, only: [:show, :edit, :update, :destroy]

  # GET /daily_routines
  # GET /daily_routines.json
  def index
    @daily_routines = DailyRoutine.all
  end

  # GET /daily_routines/1
  # GET /daily_routines/1.json
  def show
  end

  # GET /daily_routines/new
  def new
    @daily_routine = DailyRoutine.new
  end

  # GET /daily_routines/1/edit
  def edit
  end

  # POST /daily_routines
  # POST /daily_routines.json
  def create
    @daily_routine = DailyRoutine.new(daily_routine_params)

    respond_to do |format|
      if @daily_routine.save
        format.html { redirect_to @daily_routine, notice: 'Daily routine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @daily_routine }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_routines/1
  # PATCH/PUT /daily_routines/1.json
  def update
    respond_to do |format|
      if @daily_routine.update(daily_routine_params)
        format.html { redirect_to @daily_routine, notice: 'Daily routine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_routines/1
  # DELETE /daily_routines/1.json
  def destroy
    @daily_routine.destroy
    respond_to do |format|
      format.html { redirect_to daily_routines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_routine
      @daily_routine = DailyRoutine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_routine_params
      params.require(:daily_routine).permit(:user_id, :group_id, :day_performed, :weight, :power_index, :count_ex_provided, :count_ex_completed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved, :closed)
    end
end
