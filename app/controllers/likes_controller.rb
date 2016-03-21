class LikesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_like, only: [:destroy]

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.liker = current_user.id

    if @like.save!
      render action: 'show', status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:message_id)
    end
end
