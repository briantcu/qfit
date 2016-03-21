class LeadersController < ApplicationController

  # GET /leaders
  # GET /leaders.json
  #@TODO build out leaderboard json
  def index
    @leaders = Leader.all
  end

end
