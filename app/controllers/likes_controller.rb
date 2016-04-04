# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  liker      :integer
#  message_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class LikesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_like, only: [:destroy]

  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.liker = current_user.id

    if @like.save!
      render status: :created, json: {}
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1.json
  def destroy
    @like.destroy
    head :no_content
  end

  private
  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:message_id)
  end
end
