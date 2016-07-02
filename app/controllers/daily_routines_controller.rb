# == Schema Information
#
# Table name: daily_routines
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  group_id           :integer
#  day_performed      :date
#  weight             :integer
#  power_index        :integer
#  count_ex_provided  :integer
#  count_ex_completed :integer
#  program_day_id     :integer
#  wt_day_id          :integer
#  sp_day_id          :integer
#  pl_day_id          :integer
#  wu_day_id          :integer
#  modified           :boolean
#  pl_modified        :boolean
#  wt_modified        :boolean
#  wu_modified        :boolean
#  sp_modified        :boolean
#  changes_saved      :boolean          default(FALSE)
#  closed             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  group_routine_id   :integer
#  shared             :boolean          default(FALSE)
#

class DailyRoutinesController < ApplicationController
  before_filter :verify_logged_in, only: [:index]
  before_filter :verify_is_logged_in_or_coach, only: [:create, :routine_by_date]
  before_filter :verify_owns_workout, except: [:index, :create, :routine_by_date, :skip_all]
  before_action :set_daily_routine, except: [:index, :create, :routine_by_date, :skip_all]

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  def index
    @daily_routines = current_user.daily_routines.order(created_at: :desc).limit(5)
  end

  #@TODO assume you have to own a workout to see it. Need to work out sharing later
  def show
  end

  # POST /daily_routines.json
  def create
    date = Date.new(params[:daily_routine][:year].to_i, params[:daily_routine][:month].to_i, params[:daily_routine][:day].to_i)
    @daily_routine = DailyRoutine.create_routine(params[:daily_routine][:user_id], date, 0, 0, false)
    render action: :show, status: :created, location: @daily_routine
  end

  #GET /users/:user_id/daily_routines/year/:year/month/:month/day/:day
  def routine_by_date
    @daily_routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], params[:user_id])
    if @daily_routine.nil?
      render json: {}, status: 404
    else
      render action: :show
    end
  end

  # PATCH/PUT /daily_routines/1/skip.json
  def skip
    service = CloseRoutineService.new(@daily_routine)
    @daily_routine = service.skip_routine
    render action: :show, status: :ok, location: @daily_routine
  end

  #PUT /users/:user_id/daily_routines/skip_all
  def skip_all
    user_id = params[:user_id]
    workouts = DailyRoutine.get_old_open_workouts_for_user(user_id)
    service = CloseRoutineService.new(nil)
    workouts.each do |workout|
      service.set_routine(workout)
      service.skip_routine
    end
    render json: {}, status: 201
  end

  # PATCH/PUT /daily_routines/1/close.json
  def close
    if @daily_routine.update(daily_routine_params)
      service = CloseRoutineService.new(@daily_routine)
      @daily_routine = service.close_routine
      render action: :show, status: :ok, location: @daily_routine
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
      render json: perf_ex, status: :created
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
      render json: perf_sprint, status: :created
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
      render json: perf_wu, status: :created
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
      render json: perf_plyo, status: :created
    end
  end

  # POST '/daily_routines/:id/custom/:type/:name'
  def add_custom
    if RoutineService.has_exceeded_ex_count(@daily_routine, params[:type])
      render json: { success: false, errors: 'Maxed out' }, :status => 406
    else
      custom = @daily_routine.add_custom_exercise(params[:name], params[:type], 0)
      render json: custom, status: :created
    end
  end

  # GET '/daily_routines/:id/reset'
  def reset
    @daily_routine.reset
    render action: 'show', status: :ok, location: @daily_routine
  end

  def shared
    @daily_routine.user.points += 10
    @daily_routine.user.save!
    @daily_routine.update_attributes(shared: true)
    render action: :show, status: :ok, location: @daily_routine
  end

  private
  def set_daily_routine
    @daily_routine = DailyRoutine.joins(:performed_exercises, :performed_plyometrics, :performed_sprints, :performed_warm_ups).find(params[:id])
  end

  def daily_routine_params
    params.require(:daily_routine)
        .permit(:weight, :changes_saved,
                custom_exercises_attributes: [:id, :details],
                performed_warm_ups_attributes: [:id, :completed],
                performed_exercises_attributes: [:id, weight_sets_attributes: [:id, :perf_weight, :perf_reps]],
                performed_plyometrics_attributes: [:id, :performed_one, :performed_two, :performed_three],
                performed_sprints_attributes: [:id, laps_attributes: [:id, :completed]]
    )
  end

  def verify_owns_workout
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.owns_workout?(params[:id]))
  end

  def verify_is_logged_in_or_coach
    return unauthorized if current_user.nil?
    if request.request_method == 'GET'
      user_id = params[:user_id].to_i
    else
      user_id = params[:daily_routine][:user_id].to_i
    end
    unauthorized unless (current_user.id == user_id.to_i ||
        (current_user.is_coach_of_user?(user_id.to_i)) ||
        (current_user.is_super_user?))
  end

end
