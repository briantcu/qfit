class WorkoutScheduleSuggestionsController < ApplicationController

  def show
  end

  def retrieve_suggested_schedule
    @workout_schedule_suggestion = WorkoutScheduleSuggestion.where(program_type: params[:program_type_id].to_i, weight_schedule: params[:weight_schedule_id].to_i).first
    render :json => @workout_schedule_suggestion.as_json
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
