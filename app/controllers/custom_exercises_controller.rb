class CustomExercisesController < ApplicationController
  before_action :set_custom_exercise, only: [:show, :edit, :update, :destroy]

  # GET /custom_exercises
  # GET /custom_exercises.json
  def index
    @custom_exercises = CustomExercise.all
  end

  # GET /custom_exercises/1
  # GET /custom_exercises/1.json
  def show
  end

  # GET /custom_exercises/new
  def new
    @custom_exercise = CustomExercise.new
  end

  # GET /custom_exercises/1/edit
  def edit
  end

  # POST /custom_exercises
  # POST /custom_exercises.json
  def create
    @custom_exercise = CustomExercise.new(custom_exercise_params)

    respond_to do |format|
      if @custom_exercise.save
        format.html { redirect_to @custom_exercise, notice: 'Custom exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @custom_exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @custom_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_exercises/1
  # PATCH/PUT /custom_exercises/1.json
  def update
    respond_to do |format|
      if @custom_exercise.update(custom_exercise_params)
        format.html { redirect_to @custom_exercise, notice: 'Custom exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @custom_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_exercises/1
  # DELETE /custom_exercises/1.json
  def destroy
    @custom_exercise.destroy
    respond_to do |format|
      format.html { redirect_to custom_exercises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_exercise
      @custom_exercise = CustomExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_exercise_params
      params.require(:custom_exercise).permit(:rid, :details, :status, :gid, :name, :type)
    end
end
