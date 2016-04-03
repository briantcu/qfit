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
  def set_exercise_type
    @exercise_type = ExerciseType.find(params[:id])
  end

end
