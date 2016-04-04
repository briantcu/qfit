class GroupRoutinesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_routine, except: [:routine_by_date]
  before_filter :verify_owns_group, except: [:show, :routine_by_date]

  # GET /group_routines/1
  def show
  end

  #GET /groups/:group_id/group_routines/year/:year/month/:month/day/:day
  def routine_by_date
    @group_routine = GroupRoutine.get_routine_by_date(params[:month], params[:year], params[:day], params[:group_id])
    if @group_routine.nil?
      render json: {error: 'not-found'}, status: 404
    else
      render :show
    end
  end

  # POST '/group_routines/:id/weights/:exercise_id'
  def add_weight
    exercise = Exercise.find(params[:exercise_id])
    perf_ex = @group_routine.add_weights(exercise, 1, 0)
    @group_routine.note_weights_changed(true)
    render json: perf_ex, status: :created
  end

  # POST '/group_routines/:id/sprints/:sprint_id'
  def add_sprint
    sprint = Sprint.find(params[:sprint_id])
    perf_sprint = @group_routine.add_sprint(sprint.id, 1, 0)
    @group_routine.note_sprints_changed(true)
    render json: perf_sprint, status: :created
  end

  # POST '/group_routines/:id/warmups/:warmup_id'
  def add_warmup
    warmup = Warmup.find(params[:warmup_id])
    perf_wu = @group_routine.add_warmup(warmup.id, 1, 0)
    @group_routine.note_warmups_changed(true)
    render json: perf_wu.to_json
  end

  # POST '/group_routines/:id/plyos/:plyometric_id'
  def add_plyo
    plyo = Plyometric.find(params[:plyometric_id])
    perf_plyo = @group_routine.add_plyometric(plyo.id, 1, 0)
    @group_routine.note_plyos_changed(true)
    render json: perf_plyo, status: :created
  end

  # POST '/group_routines/:id/custom/:type/:name'
  def add_custom
    custom = @group_routine.add_custom_exercise(params[:name], params[:type], 0)
    render json: custom, status: :created
  end

  def reset
    @group_routine.reset
    render action: :show, status: :ok, location: @group_routine
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group_routine
    @group_routine = GroupRoutine.find(params[:id])
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@group_routine.group_id))
  end

end
