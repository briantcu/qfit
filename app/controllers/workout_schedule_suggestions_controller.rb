# == Schema Information
#
# Table name: workout_schedule_suggestions
#
#  id              :integer          not null, primary key
#  program_type    :integer
#  weight_schedule :integer
#  program_id      :integer
#  num_weight_days :integer
#  num_plyo_days   :integer
#  num_sprint_days :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class WorkoutScheduleSuggestionsController < ApplicationController
  before_filter :verify_logged_in

  def retrieve_suggested_schedule
    @workout_schedule_suggestion = WorkoutScheduleSuggestion
                                       .where(program_type: params[:program_type_id].to_i,
                                              weight_schedule: params[:weight_schedule_id].to_i).first
    render :json => @workout_schedule_suggestion.as_json
  end
end
