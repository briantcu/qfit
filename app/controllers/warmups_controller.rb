class WarmupsController < ApplicationController
  before_action :set_warmup, only: [:show]

  # GET /warmups.json
  def index
    @warmups = Warmup.all
  end

  # GET /warmups/1.json
  def show
  end

  private

  def set_warmup
    @warmup = Warmup.find(params[:id])
  end
end
