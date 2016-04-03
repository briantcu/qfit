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
