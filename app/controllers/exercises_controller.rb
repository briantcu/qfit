class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show]

  # GET /exercises/1
  # GET /exercises/1.json
  def show
  end

  private
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

end
