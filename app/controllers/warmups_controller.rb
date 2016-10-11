# == Schema Information
#
# Table name: warmups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  is_stretch :boolean
#  video_link :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ex_type    :integer
#  thumbnail  :string
#  paid_tier  :integer
#

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
