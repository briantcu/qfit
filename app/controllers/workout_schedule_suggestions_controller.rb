class WorkoutScheduleSuggestionsController < ApplicationController

  def show
  end

  def retrieve_suggested_schedule
    @workout_schedule_suggestion = WorkoutScheduleSuggestion.where(program_type: params[:program_type_id].to_i,
                                                                   weight_schedule: params[:weight_schedule_id].to_i).first
    render :json => @workout_schedule_suggestion.as_json
  end
end
