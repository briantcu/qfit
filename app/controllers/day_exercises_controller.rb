class DayExercisesController < ApplicationController
  before_action :set_day_exercise, only: [:show, :edit, :update, :destroy]

  # GET /day_exercises
  # GET /day_exercises.json
  def index
    @day_exercises = DayExercise.all
  end

  # GET /day_exercises/1
  # GET /day_exercises/1.json
  def show
  end

  # GET /day_exercises/new
  def new
    @day_exercise = DayExercise.new
  end

  # GET /day_exercises/1/edit
  def edit
  end

  # POST /day_exercises
  # POST /day_exercises.json
  def create
    @day_exercise = DayExercise.new(day_exercise_params)

    respond_to do |format|
      if @day_exercise.save
        format.html { redirect_to @day_exercise, notice: 'Day exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day_exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @day_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day_exercises/1
  # PATCH/PUT /day_exercises/1.json
  def update
    respond_to do |format|
      if @day_exercise.update(day_exercise_params)
        format.html { redirect_to @day_exercise, notice: 'Day exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_exercises/1
  # DELETE /day_exercises/1.json
  def destroy
    @day_exercise.destroy
    respond_to do |format|
      format.html { redirect_to day_exercises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_exercise
      @day_exercise = DayExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_exercise_params
      params.require(:day_exercise).permit(:program_day_id, :ex_type)
    end
end
