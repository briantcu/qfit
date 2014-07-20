class SprintsController < ApplicationController
  before_action :set_sprint, only: [:show, :edit]

  # GET /sprints
  # GET /sprints.json
  def index
    @sprints = Sprint.all
  end

  # GET /sprints/1
  # GET /sprints/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sprint
      @sprint = Sprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprint_params
      params.require(:sprint).permit(:difficulty, :name, :sprint_type, :num_laps)
    end
end
