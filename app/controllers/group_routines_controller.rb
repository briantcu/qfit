class GroupRoutinesController < ApplicationController
  before_action :set_group_routine, only: [:show, :edit, :update, :add_custom, :add_warmup, :add_plyo, :add_sprint, :add_weight]
  before_filter :verify_owns_group, only: [:routine_by_date, :add_weight, :add_sprint, :add_warmup, :add_plyo, :update, :add_custom]

  # GET /group_routines/1
  def show
  end

  #GET /groups/:group_id/group_routines/year/:year/month/:month/day/:day
  def routine_by_date
    @group_routine = GroupRoutine.get_routine_by_date(params[:month], params[:year], params[:day], params[:group_id])
    if @group_routine.nil?
      render :json => {:error => 'not-found'}.to_json, :status => 404
    else
      render 'show'
    end
  end

  # PATCH/PUT /group_routines/1
  # PATCH/PUT /group_routines/1.json
  def update
    if @group_routine.update(group_routine_params)
      render action: 'show', status: :ok, location: @group_routine
    else
      render json: @group_routine.errors, status: :unprocessable_entity
    end
  end

  # POST '/group_routines/:id/weights/:exercise_id'
  def add_weight
    exercise = Exercise.find(params[:exercise_id])
    perf_ex = @group_routine.add_weights(exercise, 1, 0)
    @group_routine.wt_modified = true
    @group_routine.modified = true
    @group_routine.save
    render json: perf_ex.to_json
  end

  # POST '/group_routines/:id/sprints/:sprint_id'
  def add_sprint
    sprint = Sprint.find(params[:sprint_id])
    perf_sprint = @group_routine.add_sprint(sprint.id, 1, 0)
    @group_routine.sp_modified = true
    @group_routine.modified = true
    @group_routine.save
    render json: perf_sprint.to_json
  end

  # POST '/group_routines/:id/warmups/:warmup_id'
  def add_warmup
    warmup = Warmup.find(params[:warmup_id])
    perf_wu = @group_routine.add_warmup(warmup.id, 1, 0)
    @group_routine.wu_modified = true
    @group_routine.modified = true
    @group_routine.save
    render json: perf_wu.to_json
  end

  # POST '/group_routines/:id/plyos/:plyometric_id'
  def add_plyo
    plyo = Plyometric.find(params[:plyometric_id])
    perf_plyo = @group_routine.add_plyometric(plyo.id, 1, 0)
    @group_routine.pl_modified = true
    @group_routine.modified = true
    @group_routine.save
    render json: perf_plyo.to_json
  end

  # POST '/group_routines/:id/custom/:type/:name'
  def add_custom
    custom = @group_routine.add_custom_exercise(params[:name], params[:type], 0)
    render json: custom.to_json
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group_routine
    @group_routine = GroupRoutine.find(params[:id])
  end

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group(params[:id]))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_routine_params
    params.require(:group_routine).permit(:group_id, :day_performed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id,
                                          :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified,
                                          :changes_saved)
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
