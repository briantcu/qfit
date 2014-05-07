class WorkoutScheduleSuggestionsController < ApplicationController
  before_action :set_workout_schedule_suggestion, only: [:show, :edit, :update, :destroy]

  # GET /workout_schedule_suggestions
  # GET /workout_schedule_suggestions.json
  def index
    @workout_schedule_suggestions = WorkoutScheduleSuggestion.all
  end

  # GET /workout_schedule_suggestions/1
  # GET /workout_schedule_suggestions/1.json
  def show
  end

  def retrieve_suggested_schedule
    @workout_schedule_suggestion = WorkoutScheduleSuggestion.where(program_type: params[:program_type_id].to_i, weight_schedule: params[:weight_schedule_id].to_i).first
    render json: @workout_schedule_suggestion, status: :ok, location: @workout_schedule_suggestion
  end

  # GET /workout_schedule_suggestions/new
  def new
    @workout_schedule_suggestion = WorkoutScheduleSuggestion.new
  end

  # GET /workout_schedule_suggestions/1/edit
  def edit
  end

  # POST /workout_schedule_suggestions
  # POST /workout_schedule_suggestions.json
  def create
    @workout_schedule_suggestion = WorkoutScheduleSuggestion.new(workout_schedule_suggestion_params)

    respond_to do |format|
      if @workout_schedule_suggestion.save
        format.html { redirect_to @workout_schedule_suggestion, notice: 'Workout schedule suggestion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @workout_schedule_suggestion }
      else
        format.html { render action: 'new' }
        format.json { render json: @workout_schedule_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workout_schedule_suggestions/1
  # PATCH/PUT /workout_schedule_suggestions/1.json
  def update
    respond_to do |format|
      if @workout_schedule_suggestion.update(workout_schedule_suggestion_params)
        format.html { redirect_to @workout_schedule_suggestion, notice: 'Workout schedule suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workout_schedule_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_schedule_suggestions/1
  # DELETE /workout_schedule_suggestions/1.json
  def destroy
    @workout_schedule_suggestion.destroy
    respond_to do |format|
      format.html { redirect_to workout_schedule_suggestions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_schedule_suggestion
      @workout_schedule_suggestion = WorkoutScheduleSuggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_schedule_suggestion_params
      params.require(:workout_schedule_suggestion).permit(:program_type, :weight_schedule, :program_id, :num_weight_days, :num_plyo_days, :num_sprint_days)
    end
end
