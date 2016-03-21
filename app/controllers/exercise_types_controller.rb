class ExerciseTypesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_exercise_type, only: [:show]

  # GET /exercise_types
  # GET /exercise_types.json
  def index
    @exercise_types = ExerciseType.all
  end

  # GET /exercise_types/1
  # GET /exercise_types/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_type
      @exercise_type = ExerciseType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_type_params
      params.require(:exercise_type).permit(:type_name)
    end
end
