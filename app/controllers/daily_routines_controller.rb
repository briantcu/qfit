class DailyRoutinesController < ApplicationController
  before_action :set_daily_routine, only: [:show, :update, :add_weight, :add_sprint, :add_warmup, :add_plyo, :close, :skip, :add_custom, :reset, :workout_shared]
  before_filter :verify_owns_workout, only: [:add_weight, :add_sprint, :add_warmup, :add_plyo, :update, :close, :skip, :add_custom, :reset]
  before_filter :verify_logged_in, only: [:routine_by_date]
  before_filter :verify_is_logged_in_or_coach, only: [:skip_all]

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  # GET /daily_routines
  def index
  end

  # GET /daily_routines/1
  def show
  end

  # This would be for adding exercises to a day that doesn't have a routine yet. Maybe can go away
  # POST /daily_routines.json
  def create
    daily_routine_parameters = daily_routine_params
    @daily_routine = DailyRoutine.create_routine(daily_routine_parameters[:user_id], daily_routine_parameters[:day_performed], 0)
    render action: 'show', status: :created, location: @daily_routine
  end

  #GET /users/:user_id/daily_routines/year/:year/month/:month/day/:day
  def routine_by_date
    @daily_routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], params[:user_id])
    if @daily_routine.nil?
      render :json => {:error => 'not-found'}.to_json, :status => 404
    else
      render 'show'
    end
  end

  #GET /users/:user_id/daily_routines/skip_all
  def skip_all
    user_id = params[:user_id]
    workouts = DailyRoutine.get_old_open_workouts_for_user(user_id)
    service = CloseRoutineService.new(nil)
    workouts.each do |workout|
      service.set_routine(workout)
      service.skip_routine
    end
  end

  # PATCH/PUT /daily_routines/1
  def update
    if @daily_routine.update(daily_routine_params)
      render action: 'show', status: :ok, location: @daily_routine
    else
      render json: @daily_routine.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_routines/1/close.json
  def close
    if @daily_routine.update(daily_routine_params)
      service = CloseRoutineService.new(@daily_routine)
      @daily_routine = service.close_routine
      render action: 'show', status: :ok, location: @daily_routine
    else
      render json: @daily_routine.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_routines/1/skip.json
  def skip
    if @daily_routine.update(daily_routine_params)
      service = CloseRoutineService.new(@daily_routine)
      @daily_routine = service.skip_routine
      render action: 'show', status: :ok, location: @daily_routine
    else
      render json: @daily_routine.errors, status: :unprocessable_entity
    end
  end

  # POST '/daily_routines/:id/weights/:exercise_id'
  def add_weight
    if RoutineService.has_exceeded_ex_count(@daily_routine, WEIGHTS)
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      exercise = Exercise.find(params[:exercise_id])
      perf_ex = @daily_routine.add_weights(exercise, 1, 0)
      @daily_routine.note_weights_changed
      render json: perf_ex.to_json
    end
  end

  # POST '/daily_routines/:id/sprints/:sprint_id'
  def add_sprint
    if RoutineService.has_exceeded_ex_count(@daily_routine, SPRINTING)
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      sprint = Sprint.find(params[:sprint_id])
      perf_sprint = @daily_routine.add_sprint(sprint.id, 1, 0)
      @daily_routine.note_sprints_changed
      render json: perf_sprint.to_json
    end
  end

  # POST '/daily_routines/:id/warmups/:warmup_id'
  def add_warmup
    if RoutineService.has_exceeded_ex_count(@daily_routine, STRETCHING)
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      warmup = Warmup.find(params[:warmup_id])
      perf_wu = @daily_routine.add_warmup(warmup.id, 1, 0)
      @daily_routine.note_warmups_changed
      render json: perf_wu.to_json
    end
  end

  # POST '/daily_routines/:id/plyos/:plyometric_id'
  def add_plyo
    if RoutineService.has_exceeded_ex_count(@daily_routine, PLYOS)
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      plyo = Plyometric.find(params[:plyometric_id])
      perf_plyo = @daily_routine.add_plyometric(plyo.id, 1, 0)
      @daily_routine.note_plyos_changed
      render json: perf_plyo.to_json
    end
  end

  # POST '/daily_routines/:id/custom/:type/:name'
  def add_custom
    if RoutineService.has_exceeded_ex_count(@daily_routine, params[:type])
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      custom = @daily_routine.add_custom_exercise(params[:name], params[:type], 0)
      render json: custom.to_json
    end
  end

  # GET '/daily_routines/:id/reset'
  def reset
    @daily_routine.reset
    render action: 'show', status: :ok, location: @daily_routine
  end

  def workout_shared
    @daily_routine.user.points += 10
    @daily_routine.user.save!
    @daily_routine.shared = true
    @daily_routine.save!
    render action: 'show', status: :ok, location: @daily_routine
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

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout?(params[:id]))
  end

  def verify_is_logged_in_or_coach
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.id == params[:user_id].to_i ||
            (current_user.is_coach_of_user?(params[:user_id].to_i)) ||
            (current_user.is_super_user?))
  end

end
