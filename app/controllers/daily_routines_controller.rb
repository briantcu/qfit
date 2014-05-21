class DailyRoutinesController < ApplicationController
  before_action :set_daily_routine, only: [:show, :edit, :update]

  # GET /daily_routines
  # GET /daily_routines.json
  def index
    @daily_routines = DailyRoutine.all
  end

  # GET /daily_routines/1
  # GET /daily_routines/1.json
  def show
  end

  #GET /daily_routines/year/:year/month/:month/day/:day
  def routine_by_date
    @daily_routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day])
    if @daily_routine.nil?
      render :json => {:error => 'not-found'}.to_json, :status => 404
    else
      render 'show'
    end
  end

  # GET /daily_routines/new
  def new
    @daily_routine = DailyRoutine.new
  end

  # GET /daily_routines/1/edit
  def edit
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_routine
      @daily_routine = DailyRoutine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_routine_params
      params.require(:daily_routine).permit(:user_id, :group_id, :day_performed, :weight, :power_index,
                                            :count_ex_provided, :count_ex_completed, :program_day_id, :wt_day_id,
                                            :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified,
                                            :wu_modified, :sp_modified, :changes_saved, :closed, :comments,
                                            custom_exercises_attributes: [:id, :details],
                                            performed_warm_ups_attributes: [:id, :completed],
                                            performed_exercises_attributes: [:id,
                                              weight_sets_attributes: [:id, :perf_weight, :perf_reps]
                                            ],
                                            performed_plyometrics_attributes: [:id, :performed_one, :performed_two,
                                                                               :performed_three],
                                            performed_sprints_attributes: [:id, laps_attributes: [:id, :completed]]
      )
    end

end
