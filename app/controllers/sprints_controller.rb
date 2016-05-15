# == Schema Information
#
# Table name: sprints
#
#  id          :integer          not null, primary key
#  difficulty  :integer
#  name        :string(255)
#  sprint_type :integer
#  num_laps    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class SprintsController < ApplicationController
  before_action :set_sprint, only: [:show]

  # GET /sprints.json
  def index
    @sprints = Sprint.all
  end

  # GET /sprints/1.json
  def show
  end

  private
  def set_sprint
    @sprint = Sprint.find(params[:id])
  end
end
