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

class WorkoutScheduleSuggestion < ActiveRecord::Base
end
