class WarmupsController < ApplicationController
  before_action :set_warmup, only: [:show, :edit]

  # GET /warmups
  # GET /warmups.json
  def index
    @warmups = Warmup.all
  end

  # GET /warmups/1
  # GET /warmups/1.json
  def show
  end

  private

  def set_warmup
    @warmup = Warmup.find(params[:id])
  end

  def warmup_params
    params.require(:warmup).permit(:name, :is_stretch, :video_link)
  end
end
