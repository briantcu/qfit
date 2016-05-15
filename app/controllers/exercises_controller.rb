# == Schema Information
#
# Table name: exercises
#
#  id               :integer          not null, primary key
#  exercise_type_id :integer
#  video_link       :string(255)
#  look_up_value    :integer
#  percent_of_luv   :float
#  category         :integer
#  difficulty       :integer
#  is_body_weight   :boolean
#  name             :string(255)
#  is_image         :boolean
#  created_at       :datetime
#  updated_at       :datetime
#  paid_tier        :integer          default(1)
#  for_time         :boolean
#

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
