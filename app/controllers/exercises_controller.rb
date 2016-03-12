class ExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_exercise, only: [:show, :edit]

  # GET /exercises
  # GET /exercises.json
  def index
    @exercise_types = ExerciseType.all
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_params
      params.require(:exercise).permit(:type, :video_link, :look_up_value, :percent_of_luv, :category, :difficulty,
                                       :is_body_weight, :name, :is_image)
    end
end
